class HasCollection < ApplicationRecord
  belongs_to :note
  belongs_to :collection
end
