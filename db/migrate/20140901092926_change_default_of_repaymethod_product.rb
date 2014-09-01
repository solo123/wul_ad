class ChangeDefaultOfRepaymethodProduct < ActiveRecord::Migration
  def change
    change_column :products, :repayment_method, :string, :default => "profit"
  end
end
