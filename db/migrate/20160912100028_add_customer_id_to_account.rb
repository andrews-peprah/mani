class AddCustomerIdToAccount < ActiveRecord::Migration[5.0]
  def up
    add_column :accounts, :customer_id, :integer
    remove_column :accounts, :client_id
  end
end
