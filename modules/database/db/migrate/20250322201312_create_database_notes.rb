class CreateDatabaseNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.references :journal, null: false, foreign_key: true
      t.string :text, null: false

      t.timestamps
    end
  end
end
