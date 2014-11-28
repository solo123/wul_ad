class AddPeriodNumber < ActiveRecord::Migration
  def change
    add_column :products, :current_profit_period, :integer,  :default => 0
    add_column :products, :current_principal_period, :integer,  :default => 0
    add_column :invests, :current_profit_period, :integer,  :default => 0
    add_column :invests, :current_principal_period, :integer,  :default => 0
    add_column :invest_profits, :profit_number, :integer,  :default => 0
    add_column :invest_principals, :principal_number, :integer,  :default => 0
    add_column :product_profits, :profit_number, :integer,  :default => 0
    add_column :product_principals, :principal_number, :integer,  :default => 0
  end
end
