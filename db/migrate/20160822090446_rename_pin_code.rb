class RenamePinCode < ActiveRecord::Migration[5.0]
  
  def up
    rename_column :customers, :pin_code, :encrypted_pin_code
  end

  def down
    rename_column :customers, :encrypted_pin_code, :pin_code
  end

end
