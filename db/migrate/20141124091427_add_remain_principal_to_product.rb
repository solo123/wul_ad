class AddRemainPrincipalToProduct < ActiveRecord::Migration
  def change
    add_column :products, :remain_principal, :decimal, :precision => 14, :scale => 2, :default => 0.0
  end
end
