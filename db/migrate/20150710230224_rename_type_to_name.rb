class RenameTypeToName < ActiveRecord::Migration
  def change
    rename_column :event_types, :type, :name
  end
end
