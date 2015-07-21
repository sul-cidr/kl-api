class DropMonumentsTable < ActiveRecord::Migration
  def change
    drop_table :monuments
  end
end
