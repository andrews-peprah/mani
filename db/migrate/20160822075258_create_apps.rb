class CreateApps < ActiveRecord::Migration[5.0]
  def up
    create_table :apps do |t|
      t.string    :name, default: ""
      t.string    :app_uid, default: ""
      t.string    :client_uid, default: ""
      t.integer   :client_id
      t.timestamps
    end
  end
end
