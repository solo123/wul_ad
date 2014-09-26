class AddSecondRetValue < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_result_value2, :decimal
    add_column :account_operations, :uinfo_id2, :decimal
  end
end
