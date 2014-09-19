class CreateAccountOperations < ActiveRecord::Migration
  def change
    create_table :account_operations do |t|
      t.string :op_action
      t.string :op_name
      t.string :operator
      t.string :user_id
      t.boolean :op_result, :default => false
      t.integer :op_result_code, :integer, :default => 0
      t.decimal :op_amount
      t.timestamps
    end
  end
end
