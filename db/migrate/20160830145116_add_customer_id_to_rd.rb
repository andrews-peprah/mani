class AddCustomerIdToRd < ActiveRecord::Migration[5.0]
  def up
    add_column :registered_devices, :customer_id, :integer
  end
end
