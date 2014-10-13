class AddRepaymentMethodToAccountProducts < ActiveRecord::Migration
  def change
    add_column :account_products, :repayment_method, :string, :default => "profit"
  end
end
