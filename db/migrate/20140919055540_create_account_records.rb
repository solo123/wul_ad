class CreateAccountRecords < ActiveRecord::Migration
  def change
    create_table :account_records do |t|
      t.string :op_name
      t.string :op_action
      t.string :op_id
      t.string :operator
      t.integer :account_id
      t.decimal :account_balance_before
      t.decimal :account_balance_after
      t.decimal :op_amount, precision: 12, scale: 2
      t.boolean :op_result
      t.integer :op_result_code
      t.string :resource_name

      t.timestamps
    end
  end
end
