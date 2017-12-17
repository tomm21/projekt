class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_name, :uniqueness => { :case_sensitive => false }
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name, :last_name, :first_name
end
