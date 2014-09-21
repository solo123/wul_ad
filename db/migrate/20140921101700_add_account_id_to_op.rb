class AddAccountIdToOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_account_id, :integer
  end
end
