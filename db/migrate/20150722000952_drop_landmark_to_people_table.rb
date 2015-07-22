class DropLandmarkToPeopleTable < ActiveRecord::Migration
  def change
    drop_table :landmark_to_people
  end
end
