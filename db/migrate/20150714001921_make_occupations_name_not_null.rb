class MakeOccupationsNameNotNull < ActiveRecord::Migration
  def change
    change_column_null :occupations, :name, false
  end
end
