class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :pin_code
      t.boolean :is_active,   default: true
      t.boolean :is_archive,  default: false
      t.string :telephone
      t.timestamps
    end

    add_index :customers, :id
  end
end
