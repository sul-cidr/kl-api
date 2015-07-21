class RemoveTypeRefFromLandmark < ActiveRecord::Migration
  def change
    remove_column :landmarks, :landmark_type_id, :integer
  end
end
