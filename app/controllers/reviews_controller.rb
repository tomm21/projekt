class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :find_movie
  before_action :has_reviewed, only: [:new]
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.movie_id=@movie.id
    @review.user_id=current_user.id   
    respond_to do |format|
      if @review.save
        if @review.rating==nil
          @review.update_attributes(:rating => 0)
        end
          @movie.update_attribute :rating, @movie.reviews.average(:rating)
        format.html {redirect_to movie_path(@movie), notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])
    @movie=Movie.find(@review.movie_id)
    if (current_user.id==@review.user.id) || (current_user.try(:admin))
      respond_to do |format|
        if @review.update(review_params)
          if @review.rating==nil
            @review.update_attributes(:rating => 0)
          end
          @movie.update_attribute :rating, @movie.reviews.average(:rating)
          format.html { redirect_to movie_path(@movie), notice: 'Review was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      redirect_to movie_path(@movie), notice: 'You are not allowed to edit others reviews' 
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @movie=Movie.find(@review.movie_id)
    if (current_user.id==@review.user.id) || (current_user.try(:admin))
      @review.destroy
      respond_to do |format|
        if @movie.reviews.blank?
          @movie.update_attribute :rating, 0
        else
          @movie.update_attribute :rating, @movie.reviews.average(:rating)
        end
        format.html { redirect_to movie_path(@movie), notice: 'Review was successfully destroyed.' }
      end
     else
      redirect_to movie_path(@movie), notice: 'You are not allowed to delete others reviews' 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_movie
      @movie=Movie.find(params[:movie_id])
    end

    def has_reviewed
      redirect_to movie_path(@movie), notice: "Już oceniłeś ten film!" if current_user.reviews.exists?(movie: @movie)
    end

end
