class AddOperationidToAcOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :operation_id, :string
  end
end
