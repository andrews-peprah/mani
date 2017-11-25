class AddClientUidToClient < ActiveRecord::Migration[5.0]
  def up
    add_column :clients, :client_uid, :string
    remove_column :apps, :client_uid
  end
end
