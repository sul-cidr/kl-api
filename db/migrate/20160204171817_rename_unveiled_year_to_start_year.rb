class RenameUnveiledYearToStartYear < ActiveRecord::Migration
  def change
    rename_column :landmarks, :unveiled_year, :start_year
  end
end
