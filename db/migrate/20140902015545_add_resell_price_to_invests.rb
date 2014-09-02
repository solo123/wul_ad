class AddResellPriceToInvests < ActiveRecord::Migration
  def change
    add_column :invests, :resell_price, :decimal
  end
end
