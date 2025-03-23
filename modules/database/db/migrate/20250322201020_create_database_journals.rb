class CreateDatabaseJournals < ActiveRecord::Migration[8.0]
  def change
    create_table :journals do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
