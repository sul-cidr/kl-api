class RemovePersonIdFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :person_id, :integer
  end
end
