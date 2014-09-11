class AddProTypeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :product_type, :string
  end
end
