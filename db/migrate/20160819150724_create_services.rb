class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string      :name, default: ""
      t.boolean     :is_active, default: true
      t.string        :description, default: ""
      t.string      :code,  default: ""
      t.string      :serverurl, default: ""
      t.timestamps
    end
    add_index :services, :id
  end
end
