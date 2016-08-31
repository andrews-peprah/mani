class ChangeParentIdToChildId < ActiveRecord::Migration[5.0]
  def up
    rename_column :parentships, :parent_id, :child_id
  end
end
