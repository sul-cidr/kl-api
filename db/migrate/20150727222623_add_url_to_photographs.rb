class AddUrlToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :url, :string, :null => false
  end
end
