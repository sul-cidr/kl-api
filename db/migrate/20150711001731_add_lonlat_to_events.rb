class AddLonlatToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lonlat, :st_point
  end
end
