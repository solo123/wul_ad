class CreateAccountProducts < ActiveRecord::Migration
  def change
    create_table :account_products do |t|
      t.string :deposit_number
      t.decimal :total_amount, precision: 12, scale: 2
      t.decimal :annual_rate, precision: 5,  scale: 2
      t.integer :repayment_period
      t.decimal :each_repayment_amount, precision: 12, scale: 2
      t.decimal :free_invest_amount, precision: 10, scale: 2
      t.decimal :fixed_invest_amount, precision: 10, scale: 2, default:0
      t.date :join_date
      t.date     :expiring_date
      t.string   :premature_redemption
      t.integer  :fee
      t.string   :product_type, default: "fixed"
      t.string   :stage, default: "open"
      t.datetime :profit_date
      t.datetime :principal_date
      t.integer  :status, default: 0
      t.timestamps
    end
  end
end
