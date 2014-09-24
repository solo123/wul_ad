class AddMinlimitToProduct < ActiveRecord::Migration
  def change
    add_column :products, :min_limit, :integer, :default => 1000
    add_column :products, :max_limit, :integer, :default => 100000
  end
end
