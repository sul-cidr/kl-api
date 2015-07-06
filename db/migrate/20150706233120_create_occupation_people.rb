class CreateOccupationPeople < ActiveRecord::Migration
  def change

    create_table :occupation_people do |t|
      t.integer :occupation_id
      t.integer :person_id
      t.index [:occupation_id, :person_id]
      t.index [:person_id, :occupation_id]
    end

    add_foreign_key :occupation_people, :occupations
    add_foreign_key :occupation_people, :people

  end
end
