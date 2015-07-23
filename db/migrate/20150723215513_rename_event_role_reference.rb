class RenameEventRoleReference < ActiveRecord::Migration
  def change
    rename_column :person_events, :role_id, :event_role_id
  end
end
