class Collection < ApplicationRecord
  belongs_to :user
  has_many :has_collections, dependent: :delete_all
  has_many :notes, through: :has_collections
  has_many :shared_collections, dependent: :delete_all
  has_many :users, through: :shared_collections

  validates :name, presence: true
  after_save :save_notes

  def shared_users=(value)
    @shared_users = value
    if @shared_users
      @shared_users.each do |su|
        SharedCollection.create(user_id: su, collection_id: self.id)
        shared_notes su
      end
    end
  end

  def shared_notes(user)
    notes = self.notes
    if notes
      notes.each do |n|
        SharedNote.create(user_id: user, note_id: n.id)
      end
    end
  end

  def notes=(value)
  	@notes = value
  end

  def save_notes
    if @notes
  	  @notes.each do |note_id|
  		  HasCollection.create(note_id: note_id, collection_id: self.id)
  	  end
    end
  end

  # Borrar coleccion compartida y notas asociadas
  def destroy_share_collection(user)
    SharedCollection.where(user_id: user, collection_id: self.id).destroy_all
    self.notes.each do |n|
      SharedNote.where(user_id: user, note_id: n.id).destroy_all
    end
  end
end
