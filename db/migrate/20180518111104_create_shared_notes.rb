class CreateSharedNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :shared_notes do |t|
      t.references :note, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
