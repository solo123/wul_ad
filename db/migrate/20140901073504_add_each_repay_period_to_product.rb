class AddEachRepayPeriodToProduct < ActiveRecord::Migration
  def change
    add_column :products, :each_repayment_period, :integer, :default => 30
  end
end
