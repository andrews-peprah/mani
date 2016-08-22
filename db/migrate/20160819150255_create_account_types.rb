class CreateAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_types do |t|
      t.string      :name, default: ""
      t.boolean     :is_active, default: true
      t.string      :features, default: ""
      t.timestamps
    end
  end
end
