class AddParametersToAnalyzer < ActiveRecord::Migration
  def change
    add_column :analyzers, :total_charge_amount, :decimal, :default => 0
    add_column :analyzers, :total_withdraw_amount, :decimal, :default => 0
    add_column :analyzers, :cash_freeze_amount, :decimal, :default => 0
    add_column :analyzers, :fee, :decimal, :default => 0
    add_column :analyzers, :coupon_profit, :decimal, :default => 0
  end
end
