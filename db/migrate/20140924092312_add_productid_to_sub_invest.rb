class AddProductidToSubInvest < ActiveRecord::Migration
  def change
    add_column :account_sub_invests, :account_product_id, :integer
  end
end
