class AddFixedAmountToFixdep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :fixed_amount, :decimal, :default => 0
  end
end
