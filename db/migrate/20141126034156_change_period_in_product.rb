class ChangePeriodInProduct < ActiveRecord::Migration
  def change
    change_column :products, :period_rate, :decimal, :precision => 14, :scale => 4, :default => 0.00
  end
end
