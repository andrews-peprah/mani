class RenameEncryptedPinCodeForCustomer < ActiveRecord::Migration[5.0]
  def up
    rename_column :customers, :encrypted_pin_code, :pin_code
  end
end
