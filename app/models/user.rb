class User < ApplicationRecord
	has_many :notes
	validates :name, uniqueness: true
	validates :email, uniqueness: true
end
