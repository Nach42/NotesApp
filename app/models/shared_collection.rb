class SharedCollection < ApplicationRecord
  belongs_to :user
  belongs_to :collection
  validates :collection, uniqueness: {scope: :user}
end
