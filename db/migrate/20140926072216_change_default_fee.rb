class ChangeDefaultFee < ActiveRecord::Migration
  def change
    change_column :products, :fee, :integer, :default => 1
    change_column :account_products, :fee, :integer, :default => 1
  end
end
