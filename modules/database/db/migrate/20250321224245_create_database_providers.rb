class CreateDatabaseProviders < ActiveRecord::Migration[8.0]
  def change
    create_table "database_clients_providers", id: false, force: :cascade do |t|
      t.integer "provider_id", null: false
      t.integer "client_id", null: false
      t.string :plan, null: false
      t.timestamps
    end

    create_table :database_providers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
