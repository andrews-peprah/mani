class CreateAccounts < ActiveRecord::Migration[5.0]
  def up
    create_table :accounts do |t|
      t.string      :fund, default: "0"
      t.boolean     :is_active, default: true
      t.boolean     :is_archived, default: false
      t.integer     :client_id
      t.timestamp 
    end

    add_index :accounts, :id
  end
end
