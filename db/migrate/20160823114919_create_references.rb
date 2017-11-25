class CreateReferences < ActiveRecord::Migration[5.0]
  def up
    create_table :references do |t|
      t.string			:value, default: ""
      t.integer			:customer_id
      t.timestamps
    end

    add_index :references, :id
  end
end
