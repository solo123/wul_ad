class AddDescToProduct < ActiveRecord::Migration
  def change
    add_column :products, :description, :string, :default => ""
  end
end
