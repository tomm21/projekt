class Category < ApplicationRecord
	has_many :movies
	validates :name, :uniqueness => { :case_sensitive => false }
end
