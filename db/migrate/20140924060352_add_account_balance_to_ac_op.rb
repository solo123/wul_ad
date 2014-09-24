class AddAccountBalanceToAcOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_result_value, :decimal
  end
end
