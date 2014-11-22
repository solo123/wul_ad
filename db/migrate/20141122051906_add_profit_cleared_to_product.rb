class AddProfitClearedToProduct < ActiveRecord::Migration
  def change
    add_column :products, :profit_cleared, :boolean, :default => false
  end
end
