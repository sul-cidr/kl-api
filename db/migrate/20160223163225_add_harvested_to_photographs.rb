class AddHarvestedToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :harvested, :boolean
  end
end
