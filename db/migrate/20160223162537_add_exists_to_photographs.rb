class AddExistsToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :exists, :boolean
  end
end
