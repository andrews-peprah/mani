class AddReferenceToTransaction < ActiveRecord::Migration[5.0]
  def up
    add_column :transactions, :reference, :string, default: ""
  end
end
