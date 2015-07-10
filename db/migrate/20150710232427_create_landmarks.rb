class CreateLandmarks < ActiveRecord::Migration
  def change

    create_table :landmarks do |t|
      t.string :name
      t.integer :landmark_type_id
      t.timestamps null: false
    end

    add_foreign_key :landmarks, :landmark_types

  end
end
