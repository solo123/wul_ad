class AddFixedPpToProduct < ActiveRecord::Migration
  def change
    add_column :products, :fixed_pp_amount, :decimal, :precision => 14, :scale => 2, :default => 0.0
  end
end
