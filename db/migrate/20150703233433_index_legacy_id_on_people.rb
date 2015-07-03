class IndexLegacyIdOnPeople < ActiveRecord::Migration
  def change
    add_index :people, :legacy_id
  end
end
