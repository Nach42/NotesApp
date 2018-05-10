class User < ApplicationRecord
	has_friendship
	has_many :collections
	has_many :notes
	validates :name, uniqueness: true, presence: true
	validates :email, uniqueness: true, presence: true
	validates :password, presence: true
end
