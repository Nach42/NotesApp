class Note < ApplicationRecord
  belongs_to :user
  has_many :has_collections,dependent: :delete_all
  has_many :collections, through: :has_collections
  validates :title, presence: true 
  validates :body, presence: true

end
