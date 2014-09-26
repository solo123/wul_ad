class CreateAccountAccount < ActiveRecord::Migration
  def change
    create_table :account_accounts do |t|
      t.integer :user_id
      t.decimal :useable_balance, default: 0.0
      t.decimal :balance, default: 0.0
      t.decimal :frozen_balance, default: 0.0
      t.decimal :total_estate, default: 0.0
      t.integer :uinfo_id
      t.timestamps
    end
  end
end
