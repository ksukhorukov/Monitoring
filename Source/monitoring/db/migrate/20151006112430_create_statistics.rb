class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :cpu_usage, null: false
      t.string :disk_usages, null: false
      t.string :total_disk, null: false
      t.integer :process_running, null: false
      t.integer :number_of_cores, null: false
      t.timestamps null: false

      t.belongs_to :server, index: true
    end
  end
end
