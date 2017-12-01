class Review < ApplicationRecord
	belongs_to :movie
	belongs_to :user
	ratyrate_rateable 'rating'
end
