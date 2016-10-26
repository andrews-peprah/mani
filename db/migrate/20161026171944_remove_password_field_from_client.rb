class RemovePasswordFieldFromClient < ActiveRecord::Migration[5.0]
  def change
    remove_column :clients, :password_digest
  end
end
