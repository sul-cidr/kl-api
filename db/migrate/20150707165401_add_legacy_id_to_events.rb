class AddLegacyIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :legacy_id, :integer
    add_index :events, :legacy_id, unique: true
  end
end
