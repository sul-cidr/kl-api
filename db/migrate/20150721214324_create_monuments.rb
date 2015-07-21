class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|

      t.string :name
      t.integer :unveiled_year
      t.st_point :lonlat
      t.timestamps null: false

      t.index :lonlat, using: :gist

    end
  end
end
