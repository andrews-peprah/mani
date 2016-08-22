class CreatePrivileges < ActiveRecord::Migration[5.0]
  def up
    create_table :privileges do |t|
      t.string :name
      t.string :keys
      t.timestamps
    end

    add_index :privileges, :id
  end
end
