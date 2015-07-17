class AddRoleIdToPersonEvent < ActiveRecord::Migration
  def change
    add_column :person_events, :role_id, :integer, :null => false
  end
end
