class CreateAccSubInvest < ActiveRecord::Migration
  def change
    create_table :account_sub_invests do |t|
      t.integer :account_sub_product_id
      t.string :loan_number
      t.decimal :amount, precision: 12, scale: 2
      t.integer :status, default: 0
      t.boolean :onsale, default: false
      t.decimal :discount_rate, default: 0
      t.timestamps
    end
  end
end
