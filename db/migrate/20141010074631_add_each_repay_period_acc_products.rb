class AddEachRepayPeriodAccProducts < ActiveRecord::Migration
  def change
    add_column :account_products, :each_repayment_period, :integer, :default => 30
  end
end
