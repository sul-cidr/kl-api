class AddCopyrightPermissionToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :copyright_permission, :bool
  end
end
