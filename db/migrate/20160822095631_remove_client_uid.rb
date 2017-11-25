class RemoveClientUid < ActiveRecord::Migration[5.0]
  def up
    remove_column :clients, :client_uid
  end
end
