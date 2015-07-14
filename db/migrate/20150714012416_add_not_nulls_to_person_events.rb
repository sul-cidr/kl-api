class AddNotNullsToPersonEvents < ActiveRecord::Migration
  def change
    change_column_null :person_events, :person_id, false
    change_column_null :person_events, :event_id, false
  end
end
