class RemoveDerivativeUrlsFromPhotographs < ActiveRecord::Migration
  def change
    remove_column :photographs, :fsize_url, :string
    remove_column :photographs, :thumb_url, :string
    remove_column :photographs, :harvested, :boolean
  end
end
