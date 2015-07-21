class AddNotNullsToLandmarkToPerson < ActiveRecord::Migration
  def change
    change_column_null :landmark_to_people, :landmark_id, false
    change_column_null :landmark_to_people, :person_id, false
  end
end
