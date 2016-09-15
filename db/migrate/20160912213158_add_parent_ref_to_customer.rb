class AddParentRefToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :references, :parent_reference, :string, default: ""
  end

  def down
    remove_column :references, :parent_reference
  end
end
