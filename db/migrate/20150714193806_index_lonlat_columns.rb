class IndexLonlatColumns < ActiveRecord::Migration
  def change
    add_index :events, :lonlat, using: :gist
    add_index :landmarks, :lonlat, using: :gist
    add_index :photographs, :lonlat, using: :gist
  end
end
