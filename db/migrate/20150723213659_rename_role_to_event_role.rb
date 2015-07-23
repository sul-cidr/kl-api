class RenameRoleToEventRole < ActiveRecord::Migration
  def change
    rename_table :roles, :event_roles
  end
end
