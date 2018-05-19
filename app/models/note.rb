class Note < ApplicationRecord
  belongs_to :user
  
  has_many :has_collections,dependent: :delete_all
  has_many :collections, through: :has_collections
  has_many :shared_notes, dependent: :delete_all
  has_many :users, through: :shared_notes

  validates :title, presence: true 
  validates :body, presence: true

  has_attached_file :photo#, styles: {ancho: "500x300", largo: "300x500"}
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def shared_users=(value)
  	@shared_users = value
  	if @shared_users
  		@shared_users.each do |su|
  			SharedNote.create(user_id: su, note_id: self.id)
  		end
  	end
  end

end
