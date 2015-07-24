class AddRelToJoinTables < ActiveRecord::Migration
  def change
    rename_table :person_events, :person_event_rels
    rename_table :person_occupations, :person_occupation_rels
  end
end
