class AddDepIdToSubAccProduct < ActiveRecord::Migration
  def change
    add_column :account_sub_products, :deposit_number, :string
  end
end
