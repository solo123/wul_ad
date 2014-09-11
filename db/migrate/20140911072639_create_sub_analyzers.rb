class CreateSubAnalyzers < ActiveRecord::Migration
  def change
    create_table :sub_analyzers do |t|
      t.integer :analyzer_id
      t.string :product_type
      t.decimal :total_pricipal, default: 0.0
      t.decimal :total_profit, default: 0.0
      t.decimal :punishment_amount, default: 0.0
      t.decimal :resell_amount, default: 0.0
      t.decimal :buyin_amount, default: 0.0
      t.decimal :total_invest_amount, default: 0.0
      t.decimal :invest_freeze_amount, default: 0.0
      t.decimal :order_freeze_amount, default: 0.0
      t.decimal :resell_profit, default: 0.0
      t.decimal :buyin_profit, default: 0.0
      t.decimal :resell_discount_amount, default: 0.0
      t.decimal :buyin_discount_amount, default: 0.0
      t.decimal :resell_fee, default: 0.0
      t.decimal :remain_pricipal, default: 0.0
      t.decimal :remain_profit, default: 0.0
      t.timestamps
    end
  end
end
