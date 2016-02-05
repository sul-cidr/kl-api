class AddLegacyIdToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :legacy_id, :string
  end
end
