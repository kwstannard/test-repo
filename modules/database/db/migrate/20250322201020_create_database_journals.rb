class CreateDatabaseJournals < ActiveRecord::Migration[8.0]
  def change
    create_table :database_journals do |t|
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
