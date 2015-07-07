class AddDatesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date, :date
    add_column :events, :year, :integer
  end
end
