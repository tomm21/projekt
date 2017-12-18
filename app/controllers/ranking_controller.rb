class RankingController < ApplicationController
	def index
		if params[:category].blank?
			@movies = Movie.all.order("rating DESC")
		else
			@category_id=Category.find_by(name: params[:category]).id
			@movies = Movie.where(:category_id => @category_id).order("rating DESC")
		end
	end
end
