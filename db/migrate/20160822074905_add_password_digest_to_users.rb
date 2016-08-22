class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :admins, :password_digest, :string
    add_column :employees, :password_digest, :string
    add_column :customers, :password_digest, :string
    add_column :clients, :password_digest, :string
  end
end
