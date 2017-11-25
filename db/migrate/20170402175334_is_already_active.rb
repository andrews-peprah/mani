class IsAlreadyActive < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :activation_count, :integer, default: 0

    # Check activation count for all customers
    Customer.all.each do |customer|
      if customer.is_verified
        customer.activation_count = 1
        customer.save
      end
    end
  end
end
