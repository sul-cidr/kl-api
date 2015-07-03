class AddLegacyIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :legacy_id, :string
  end
end
