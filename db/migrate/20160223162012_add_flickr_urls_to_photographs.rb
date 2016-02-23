class AddFlickrUrlsToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :fsize_url, :string
    add_column :photographs, :thumb_url, :string
  end
end
