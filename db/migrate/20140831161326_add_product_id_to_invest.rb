class AddProductIdToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :product_id, :integer
  end
end
