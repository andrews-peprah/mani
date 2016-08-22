class CreateClients < ActiveRecord::Migration[5.0]
  def up
    create_table :clients do |t|
      t.string :first_name,   default: ""
      t.string :last_name,    default: ""
      t.string :company,      default: ""
      t.boolean :is_active,   default: true
      t.string :password
      t.boolean :is_archived, default: false
      t.string :callbackurl,  default: ""
      t.timestamps
    end
  end
end
