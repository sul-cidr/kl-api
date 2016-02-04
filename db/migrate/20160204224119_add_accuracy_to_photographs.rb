class AddAccuracyToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :accuracy, :int
  end
end
