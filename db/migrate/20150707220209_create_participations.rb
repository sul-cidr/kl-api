class CreateParticipations < ActiveRecord::Migration
  def change

    create_table :participations do |t|
      t.integer :person_id
      t.integer :event_id
      t.index [:person_id, :event_id]
      t.index [:event_id, :person_id]
    end

    add_foreign_key :participations, :people
    add_foreign_key :participations, :events

  end
end
