class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer     :customer_id
      t.string      :amount, default: "0"
      t.string      :is_archived, default: false
      t.string      :remarks
      t.timestamps
    end
  end
end
