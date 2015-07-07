class CreateEvents < ActiveRecord::Migration
  def change

    create_table :events do |t|
      t.integer :person_id
      t.string :name
      t.timestamps null: false
    end

    add_foreign_key :events, :people

  end
end
