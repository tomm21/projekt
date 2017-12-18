class UsersController < ApplicationController
before_action :find_user
before_action :find_reviews, only: [:show]
def index
end

def show
end

private
	def find_user
		@user = User.find(params[:id])
	end
	def find_reviews
	    @reviews = @user.reviews
    end
end
