class RemoveOccupationRefFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :occupation_id
  end
end
