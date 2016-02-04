class AddLicenseToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :license, :int
  end
end
