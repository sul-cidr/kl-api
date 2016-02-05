class AddNotesToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :notes, :text
  end
end
