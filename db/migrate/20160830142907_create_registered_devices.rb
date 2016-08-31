class CreateRegisteredDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :registered_devices do |t|
      t.string :gcm_id

      t.timestamps
    end
  end
end
