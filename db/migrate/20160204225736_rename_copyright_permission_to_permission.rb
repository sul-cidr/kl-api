class RenameCopyrightPermissionToPermission < ActiveRecord::Migration
  def change
    rename_column :photographs, :copyright_permission, :permission
  end
end
