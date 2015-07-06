class AddBirthDeathCircaToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birth_circa, :boolean
    add_column :people, :death_circa, :boolean
  end
end
