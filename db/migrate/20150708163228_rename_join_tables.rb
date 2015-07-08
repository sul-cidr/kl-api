class RenameJoinTables < ActiveRecord::Migration
  def change
    rename_table :occupation_people, :person_occupations
    rename_table :participations, :person_events
  end
end
