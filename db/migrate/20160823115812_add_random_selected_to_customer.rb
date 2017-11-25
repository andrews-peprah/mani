class AddRandomSelectedToCustomer < ActiveRecord::Migration[5.0]
  def up
  	add_column :customers, :random_selected, :boolean, default: false
  end
end
