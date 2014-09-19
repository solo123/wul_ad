class AddOpParameterToRecord < ActiveRecord::Migration
  def change
    add_column :account_records, :op_result, :boolean
    add_column :account_records, :op_result_code, :integer
  end
end
