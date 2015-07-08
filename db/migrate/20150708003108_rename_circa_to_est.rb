class RenameCircaToEst < ActiveRecord::Migration
  def change
    rename_column :people, :birth_circa, :birth_est
    rename_column :people, :death_circa, :death_est
  end
end
