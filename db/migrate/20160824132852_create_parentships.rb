class CreateParentships < ActiveRecord::Migration[5.0]
  def change
    create_table :parentships do |t|
      t.integer   :customer_id
      t.integer   :parent_id
      t.timestamps
    end
  end
end
