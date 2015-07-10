class AddIndexToLandmarkTypes < ActiveRecord::Migration
  def change
    add_index :landmark_types, :name, unique: true
  end
end
