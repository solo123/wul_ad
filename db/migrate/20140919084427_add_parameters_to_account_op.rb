class AddParametersToAccountOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_resource_name, :string
    add_column :account_operations, :op_resource_id, :integer
  end
end
