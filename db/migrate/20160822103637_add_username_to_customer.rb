class AddUsernameToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :username, :string
  end
end
