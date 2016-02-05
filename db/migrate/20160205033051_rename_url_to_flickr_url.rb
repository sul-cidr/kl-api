class RenameUrlToFlickrUrl < ActiveRecord::Migration
  def change
    rename_column :photographs, :url, :flickr_url
  end
end
