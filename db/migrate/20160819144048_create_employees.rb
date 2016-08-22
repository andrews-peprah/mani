class CreateEmployees < ActiveRecord::Migration[5.0]
  def up
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone
      t.boolean :is_active, default: true
      t.boolean :is_archive, default: false
      t.integer :client_id
      t.integer :privilege_id
      t.timestamps
    end

    add_index :employees, :id
    add_index :employees, :email
    add_index :employees, :telephone
  end
end
