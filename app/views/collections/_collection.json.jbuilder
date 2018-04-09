json.extract! collection, :id, :name, :user_id, :note_id, :created_at, :updated_at
json.url collection_url(collection, format: :json)
