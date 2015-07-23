class RenameEventTypeReference < ActiveRecord::Migration
  def change
    rename_column :events, :event_type_id, :type_id
  end
end
