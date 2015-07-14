class AddNotNullsToPersonOccupations < ActiveRecord::Migration
  def change
    change_column_null :person_occupations, :occupation_id, false
    change_column_null :person_occupations, :person_id, false
  end
end
