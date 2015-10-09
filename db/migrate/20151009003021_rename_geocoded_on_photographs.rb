class RenameGeocodedOnPhotographs < ActiveRecord::Migration
  def change
    rename_column :photographs, :geocode, :needs_coord
  end
end
