class AddCreditToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :credit, :string
  end
end
