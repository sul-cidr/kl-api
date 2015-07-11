class AddLonlatToLandmark < ActiveRecord::Migration
  def change
    add_column :landmarks, :lonlat, :st_point
  end
end
