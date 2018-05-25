class User < ApplicationRecord
	
	has_friendship
	has_many :collections, dependent: :destroy
	has_many :notes, dependent: :destroy
	has_many :shared_notes, dependent: :delete_all
  	has_many :notes, through: :shared_notes

  	has_many :shared_collections, dependent: :delete_all
  	has_many :collections, through: :shared_collections

	validates :name, uniqueness: true, presence: true
	validates :email, uniqueness: true, presence: true
	validates :password, presence: true
	before_destroy :delete_notes_collections
	def is_normal_user?
		self.permission_level >=1
	end
	def is_admin?
		self.permission_level >=2
	end
	def is_super_admin?
		self.permission_level >=3
	end

	def delete_notes_collections
		self.notes.each do |note|
			note.destroy
		end

		self.collections.each do |collection|
			collection.destroy
		end
	end
end
