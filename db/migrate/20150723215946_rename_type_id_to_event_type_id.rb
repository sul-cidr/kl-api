class RenameTypeIdToEventTypeId < ActiveRecord::Migration
  def change
    rename_column :events, :type_id, :event_type_id
  end
end
