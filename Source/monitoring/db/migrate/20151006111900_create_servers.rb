class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :api_key, null: false
      t.timestamps null: false
    end
  end
end
