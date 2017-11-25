class AddPayTokenToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :pay_token, :string, default: ""
  end
end
