class Movie < ApplicationRecord
	belongs_to :category
	has_many :reviews
	validates :title, :uniqueness => { :case_sensitive => false }
end
