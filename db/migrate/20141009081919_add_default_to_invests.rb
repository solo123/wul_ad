class AddDefaultToInvests < ActiveRecord::Migration
  def change
    change_column :invests, :amount, :decimal, :default => 0,:precision => 12, :scale => 2
    change_column :invests, :annual_rate, :decimal, :default => 0,:precision => 12, :scale => 2
  end
end
