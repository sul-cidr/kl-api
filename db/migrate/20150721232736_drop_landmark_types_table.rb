class DropLandmarkTypesTable < ActiveRecord::Migration
  def change
    drop_table :landmark_types
  end
end
