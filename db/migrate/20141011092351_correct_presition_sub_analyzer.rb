class CorrectPresitionSubAnalyzer < ActiveRecord::Migration
  def change
    change_column :sub_analyzers, :total_principal, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :total_profit, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :punishment_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :resell_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :buyin_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :total_invest_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :invest_freeze_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :order_freeze_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :resell_profit, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :buyin_profit, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :resell_discount_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :buyin_discount_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :resell_fee, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :remain_pricipal, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :sub_analyzers, :remain_profit, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
