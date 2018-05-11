class Note < ApplicationRecord
  belongs_to :user
  has_many :has_collections,dependent: :delete_all
  has_many :collections, through: :has_collections
  validates :title, presence: true 
  validates :body, presence: true

  has_attached_file :photo#, styles: {ancho: "500x300", largo: "300x500"}
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

end
