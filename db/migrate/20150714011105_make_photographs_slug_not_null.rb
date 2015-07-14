class MakePhotographsSlugNotNull < ActiveRecord::Migration
  def change
    add_index :photographs, :slug, unique: true
    change_column_null :photographs, :slug, false
  end
end
