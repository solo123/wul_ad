class AddPeriodNumbersToOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_profit_period, :integer,  :default => 0
    add_column :account_operations, :op_principal_period, :integer,  :default => 0
  end
end
