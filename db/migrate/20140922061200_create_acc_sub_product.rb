class CreateAccSubProduct < ActiveRecord::Migration
  def change
    create_table :account_sub_products do |t|
      t.integer :account_product_id
      t.integer :account_account_id
      t.decimal :total_amount, default: 0.0
      t.timestamps
    end
  end
end
