class AddFeeToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :fee, :string
  end
end
