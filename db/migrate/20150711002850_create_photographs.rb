class CreatePhotographs < ActiveRecord::Migration
  def change
    create_table :photographs do |t|
      t.string :slug
      t.st_point :lonlat
      t.timestamps null: false
    end
  end
end
