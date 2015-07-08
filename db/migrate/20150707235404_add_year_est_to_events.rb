class AddYearEstToEvents < ActiveRecord::Migration
  def change
    add_column :events, :year_est, :boolean
  end
end
