class MakeLandmarkTypesNameNotNull < ActiveRecord::Migration
  def change
    change_column_null :landmark_types, :name, false
  end
end
