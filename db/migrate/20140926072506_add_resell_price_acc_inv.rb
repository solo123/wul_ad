class AddResellPriceAccInv < ActiveRecord::Migration
  def change
    add_column :account_sub_invests, :resell_price, :decimal
  end
end
