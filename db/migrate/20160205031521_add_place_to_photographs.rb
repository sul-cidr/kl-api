class AddPlaceToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :place, :string
  end
end
