class RemovePasswordDigest < ActiveRecord::Migration[5.0]
  def change
    remove_column :admins, :password_digest
  end
end
