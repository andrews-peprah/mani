class CreateAccountHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :account_histories do |t|
      t.integer :account_id
      t.string :amount, default: "0"
      t.string :transaction_type
                    
      t.timestamps
    end

    add_index :account_histories, :id
  end
end
