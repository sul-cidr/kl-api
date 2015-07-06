class AddUniqueIndexToLegacyId < ActiveRecord::Migration
  def change
    remove_index :people, :legacy_id
    add_index :people, :legacy_id, :unique => true
  end
end
