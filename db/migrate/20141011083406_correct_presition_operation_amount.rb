class CorrectPresitionOperationAmount < ActiveRecord::Migration
  def change
    change_column :transactions, :operation_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
