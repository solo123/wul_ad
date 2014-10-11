class CorrectPresitionAnalyzer < ActiveRecord::Migration
  def change
    change_column :analyzers, :invest_num, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :analyzers, :total_charge_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :analyzers, :total_withdraw_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :analyzers, :cash_freeze_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :analyzers, :fee, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :analyzers, :coupon_profit, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
