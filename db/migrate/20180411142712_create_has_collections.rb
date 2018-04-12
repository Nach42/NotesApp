class CreateHasCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :has_collections do |t|
      t.references :note, foreign_key: true
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
