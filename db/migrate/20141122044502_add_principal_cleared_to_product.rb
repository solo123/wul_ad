class AddPrincipalClearedToProduct < ActiveRecord::Migration
  def change
    add_column :products, :principal_cleared, :boolean, :default => false
  end
end
