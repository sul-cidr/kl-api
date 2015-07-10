class RenameCodeToType < ActiveRecord::Migration
  def change
    rename_column :event_types, :code, :type
  end
end
