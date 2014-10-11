class CorrectPresition < ActiveRecord::Migration
  def change
    change_column :account_invest_profits, :refund_amount, :decimal, :precision => 15, :scale => 4
    change_column :account_operations, :op_amount, :decimal, :precision => 15, :scale => 4
    change_column :account_operations, :uinfo_id2, :integer
    change_column :account_product_profits, :refund_amount, :decimal, :precision => 15, :scale => 4
  end
end
