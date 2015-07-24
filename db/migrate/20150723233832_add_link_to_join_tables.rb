class AddLinkToJoinTables < ActiveRecord::Migration
  def change
    rename_table :person_events, :person_event_links
    rename_table :person_occupations, :person_occupation_links
  end
end
