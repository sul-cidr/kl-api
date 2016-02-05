class AddPermissionDateToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :permission_date, :date
  end
end
