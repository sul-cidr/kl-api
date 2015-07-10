class CreateLandmarkTypes < ActiveRecord::Migration
  def change
    create_table :landmark_types do |t|
      t.string :name
    end
  end
end
