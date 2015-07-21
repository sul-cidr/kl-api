class AddUnveiledYearToLandmark < ActiveRecord::Migration
  def change
    add_column :landmarks, :unveiled_year, :integer
  end
end
