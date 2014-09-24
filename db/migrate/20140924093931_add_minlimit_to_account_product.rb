class AddMinlimitToAccountProduct < ActiveRecord::Migration
  def change
    add_column :account_products, :min_limit, :integer, :default => 1000
    add_column :account_products, :max_limit, :integer, :default => 100000
  end
end
