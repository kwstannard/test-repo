class CreateDatabaseProviders < ActiveRecord::Migration[8.0]
  def change
    create_join_table :providers, :clients, table_name: :database_clients_providers

    create_table :database_providers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
