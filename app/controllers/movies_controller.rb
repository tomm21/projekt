class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_filter :redirect_to_root, only: [:new, :edit, :update, :destroy]
  before_action :find_reviews, only: [:show]
  # GET /movies
  # GET /movies.json
  def index
    if params[:category].blank?
      @movies = Movie.all
    else
      @category_id=Category.find_by(name: params[:category]).id
      @movies = Movie.where(:category_id => @category_id)
    end
  end


  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    if current_user.try(:admin?)
      @movie = Movie.new(movie_params)
      respond_to do |format|
        if @movie.save
          format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
          format.json { render :show, status: :created, location: @movie }
        else
          format.html { render :new }
          format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path,  notice: 'Only admin is allowed to create a new movie'  
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    if current_user.try(:admin?)
      respond_to do |format|
        if @movie.update(movie_params)
          format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
          format.json { render :show, status: :ok, location: @movie }
        else
          format.html { render :edit }
          format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path,  notice: 'Only admin is allowed to edit a new movie'  
    end  
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @reviews = @movie.reviews
    if @reviews.empty?  
      if current_user.try(:admin?)
        @movie.destroy
        respond_to do |format|
          format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
        redirect_to root_path,  notice: 'Only admin is allowed to delete a new movie'  
      end
    else
      respond_to do |format|
        format.html { redirect_to movies_url, notice: 'Cannot delete movie becouse it belongs to a review' }
      end
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :director, :length,:category_id)
    end

    def redirect_to_root    
      redirect_to root_path unless current_user.try(:admin?)
    end

    def find_reviews
      @movie = Movie.find(params[:id])
      @reviews = @movie.reviews
    end

end
