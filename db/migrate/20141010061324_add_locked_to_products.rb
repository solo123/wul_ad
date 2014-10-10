class AddLockedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :locked, :boolean, :default => false
  end
end
