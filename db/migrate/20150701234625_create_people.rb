class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :family_name
      t.string :given_name

      t.timestamps null: false
    end
  end
end
