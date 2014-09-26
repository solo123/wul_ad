class CreateAnalyzers < ActiveRecord::Migration
  def change
    create_table :analyzers do |t|
      t.string :product
      t.integer :owner_num
      t.decimal :invest_num
      t.integer :user_info_id
      t.decimal :total_charge_amount, :default => 0
      t.decimal :total_withdraw_amount, :default => 0
      t.decimal :cash_freeze_amount, :default => 0
      t.decimal :fee, :default => 0
      t.decimal :coupon_profit, :default => 0

      t.timestamps
    end
  end
end
