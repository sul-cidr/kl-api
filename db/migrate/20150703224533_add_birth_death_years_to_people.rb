class AddBirthDeathYearsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birth_year, :integer
    add_column :people, :death_year, :integer
  end
end
