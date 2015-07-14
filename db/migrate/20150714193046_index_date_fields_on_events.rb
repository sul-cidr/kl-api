class IndexDateFieldsOnEvents < ActiveRecord::Migration
  def change
    add_index :events, :year
    add_index :events, :date
  end
end
