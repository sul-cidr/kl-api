class CreateJoinTableOccupationPerson < ActiveRecord::Migration
  def change

    create_join_table :occupations, :people do |t|
       t.index [:occupation_id, :person_id]
       t.index [:person_id, :occupation_id]
    end

    add_foreign_key :occupations_people, :occupations
    add_foreign_key :occupations_people, :people

  end
end
