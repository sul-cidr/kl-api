class AddImageUrlToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :image_url, :string
  end
end
