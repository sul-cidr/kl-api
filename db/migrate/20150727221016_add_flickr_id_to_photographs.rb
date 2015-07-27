class AddFlickrIdToPhotographs < ActiveRecord::Migration
  def change
    remove_column :photographs, :slug, :string
    add_column :photographs, :flickr_id, :bigint, :null => false
    add_index :photographs, :flickr_id, :unique => true
  end
end
