class HasCollection < ApplicationRecord
  belongs_to :note
  belongs_to :collection
  validates :note, uniqueness: {scope: :collection}
end
