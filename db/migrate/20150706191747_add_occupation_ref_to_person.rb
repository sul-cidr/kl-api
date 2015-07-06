class AddOccupationRefToPerson < ActiveRecord::Migration
  def change
    add_column :people, :occupation_id, :integer
    add_foreign_key :people, :occupations
  end
end
