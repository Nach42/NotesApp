class Collection < ApplicationRecord
  belongs_to :user
  has_many :has_collections
  has_many :notes, through: :has_collections
  validates :name, presence: true
  after_save :save_notes

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
end
