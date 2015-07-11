class CreateRelations < ActiveRecord::Migration
  def change

    create_table :relations do |t|
      t.integer :source_id
      t.integer :target_id
      t.index [:source_id, :target_id]
      t.index [:target_id, :source_id]
    end

    add_foreign_key :relations, :people, column: :source_id
    add_foreign_key :relations, :people, column: :target_id

  end
end
