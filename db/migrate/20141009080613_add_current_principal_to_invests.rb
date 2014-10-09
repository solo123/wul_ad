class AddCurrentPrincipalToInvests < ActiveRecord::Migration
  def change
    add_column :invests, :current_principal, :decimal, :default => 0
  end
end
