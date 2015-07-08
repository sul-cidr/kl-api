class RemoveYearEstFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :year_est, :boolean
  end
end
