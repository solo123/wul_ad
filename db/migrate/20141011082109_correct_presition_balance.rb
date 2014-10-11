class CorrectPresitionBalance < ActiveRecord::Migration
  def change
    change_column :accounts, :balance, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
