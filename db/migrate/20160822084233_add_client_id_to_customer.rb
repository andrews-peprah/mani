class AddClientIdToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :client_id, :integer
  end
end
