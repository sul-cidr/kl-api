class RemoveStartYearFromLandmarks < ActiveRecord::Migration
  def change
    remove_column :landmarks, :start_year, :integer
  end
end
