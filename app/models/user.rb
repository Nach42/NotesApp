class User < ApplicationRecord
	has_many :collections
	has_many :notes
	
	has_many :relationships,foreign_key: "follower_id"
	has_many :passive_relationships,class_name:"Relationship",foreign_key:"followed_id"
	
	has_many :followees, through: :relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	
	validates :name, uniqueness: true, presence: true
	validates :email, uniqueness: true, presence: true
	validates :password, presence: true

	def follow(other_user)
		relationships.create(followed_id: other_user.id)
	end

	def unfollow(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	def following?(other_user)
		following.include?(other_user)
	end
end
