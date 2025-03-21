class CreateDatabaseClients < ActiveRecord::Migration[8.0]
  def change
    create_table :database_clients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :plan, null: false

      t.timestamps
    end
  end
end
