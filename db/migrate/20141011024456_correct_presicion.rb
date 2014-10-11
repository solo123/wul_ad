class CorrectPresicion < ActiveRecord::Migration
  def change
    change_column :account_invest_profits, :refund_amount, :decimal, :precision => 10, :scale => 6
    change_column :account_operations, :op_amount, :decimal, :precision => 10, :scale => 0
    change_column :account_operations, :uinfo_id2, :integer
    change_column :account_product_profits, :refund_amount, :decimal, :precision => 10, :scale => 6
  end
end
