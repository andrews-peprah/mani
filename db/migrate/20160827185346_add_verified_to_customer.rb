class AddVerifiedToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :is_verified, :boolean, default: false
  end
end
