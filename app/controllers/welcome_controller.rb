class WelcomeController < ApplicationController
before_action :find_latest_movies, only: [:index]
before_action :find_highest_rated, only: [:index]

  def index
  end
  private
  	def find_latest_movies 
  		@movies = Movie.order('created_at DESC').last(5)
  	end

  	def find_highest_rated
  		@moviesRated = Movie.order('rating DESC').first(5)
  	end
end
