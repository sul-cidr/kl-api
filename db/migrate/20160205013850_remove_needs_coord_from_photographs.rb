class RemoveNeedsCoordFromPhotographs < ActiveRecord::Migration
  def change
    remove_column(
      :photographs,
      :needs_coord,
      :bool,
      default: false,
      null: false,
    )
  end
end
