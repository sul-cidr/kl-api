class AddIndexToEventTypes < ActiveRecord::Migration
  def change
    add_index :event_types, :name, unique: true
    change_column_null :event_types, :name, false
  end
end
