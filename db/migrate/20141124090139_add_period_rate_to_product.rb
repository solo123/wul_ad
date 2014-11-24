class AddPeriodRateToProduct < ActiveRecord::Migration
  def change
    add_column :products, :period_rate, :decimal, :precision => 14, :scale => 2, :default => 0.0
  end
end
