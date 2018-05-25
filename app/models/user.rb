class User < ApplicationRecord
	
	has_friendship
	has_many :collections
	has_many :notes
	has_many :shared_notes, dependent: :delete_all
  	has_many :notes, through: :shared_notes

  	has_many :shared_collections, dependent: :delete_all
  	has_many :collections, through: :shared_collections

	validates :name, uniqueness: true, presence: true
	validates :email, uniqueness: true, presence: true
	validates :password, presence: true
	

	def is_normal_user?
		self.permission_level >=1
	end
	def is_admin?
		self.permission_level >=2
	end
	def is_super_admin?
		self.permission_level >=3
	end
end
