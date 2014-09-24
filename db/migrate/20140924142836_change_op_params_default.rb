class ChangeOpParamsDefault < ActiveRecord::Migration
  def change
    change_column :account_operations, :op_result_code, :integer, :default => 512
  end
end
