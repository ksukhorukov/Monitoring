class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :statistics, :disk_usages, :disk_usage
  end
end
