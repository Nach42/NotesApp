class SharedNote < ApplicationRecord
  belongs_to :note
  belongs_to :user
  validates :note, uniqueness: {scope: :user}
end
