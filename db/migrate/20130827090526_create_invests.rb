class CreateInvests < ActiveRecord::Migration
  def change
    create_table :invests do |t|
			t.belongs_to :user_info
      t.string :loan_number
      t.string :transaction_number
			t.string :address
			t.string :usage
			t.text :usage_detail
			t.string :credit_level
			t.decimal :annual_rate
			t.decimal :amount
			t.integer :repayment_period
			t.string :repayment_method
			t.decimal :each_repayment_amount
			t.decimal :free_invest_amount
			t.datetime :invest_end_date
			t.string :remark
			t.integer :status

      t.timestamps
    end
  end
end
