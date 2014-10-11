class CorrectPresitionTransactioin < ActiveRecord::Migration
  def change
    change_column :transactions, :account_before, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :transactions, :account_after, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :transactions, :frozen_before, :decimal, :precision => 12, :scale => 2, :default => 0.00
    change_column :transactions, :frozen_after, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
