class RequireRefsOnRelations < ActiveRecord::Migration
  def change
    change_column_null :relations, :source_id, false
    change_column_null :relations, :target_id, false
  end
end
