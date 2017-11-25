class CreateTokens < ActiveRecord::Migration[5.0]
  def up
    create_table :tokens do |t|
      t.integer   :client_id
      t.integer   :customer_id
      t.integer   :employee_id
      t.string    :token, default: ""
      t.datetime  :expires_at
      t.timestamps
    end
  end
  
  def down
    drop_table :tokens
  end
end
