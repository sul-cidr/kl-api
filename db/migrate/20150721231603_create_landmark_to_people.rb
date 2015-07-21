class CreateLandmarkToPeople < ActiveRecord::Migration
  def change

    create_table :landmark_to_people do |t|
      t.integer :landmark_id
      t.integer :person_id
      t.index [:landmark_id, :person_id]
      t.index [:person_id, :landmark_id]
    end

    add_foreign_key :landmark_to_people, :landmarks
    add_foreign_key :landmark_to_people, :people

  end
end
