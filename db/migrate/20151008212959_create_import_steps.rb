class CreateImportSteps < ActiveRecord::Migration
  def change
    create_table :import_steps do |t|
      t.string :step, :null => false
      t.index :step, unique: true
    end
  end
end
