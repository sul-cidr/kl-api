class AddGeocodeToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :geocode, :boolean, null: false, default: false
  end
end
