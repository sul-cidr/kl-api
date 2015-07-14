class DropRelationsTable < ActiveRecord::Migration
  def change
    drop_table :relations
  end
end
