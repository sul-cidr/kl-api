class AddUniqueIndexToOccupation < ActiveRecord::Migration
  def change
    add_index :occupations, :name, :unique => true
  end
end
