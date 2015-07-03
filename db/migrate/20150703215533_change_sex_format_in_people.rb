class ChangeSexFormatInPeople < ActiveRecord::Migration
  def up
    change_column :people, :sex, :string
  end
  def down
    change_column :people, :sex, :integer
  end
end
