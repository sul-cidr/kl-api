class AddHarvestedUrlToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :harvested_url, :string
  end
end
