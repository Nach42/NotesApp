class CreateSharedCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :shared_collections do |t|
      t.references :user, foreign_key: true
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
