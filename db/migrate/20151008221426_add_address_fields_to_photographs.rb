class AddAddressFieldsToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :title, :string
    add_column :photographs, :address, :string
  end
end
