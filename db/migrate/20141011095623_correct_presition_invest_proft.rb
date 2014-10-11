class CorrectPresitionInvestProft < ActiveRecord::Migration
  def change
    change_column :invest_profits, :refund_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
