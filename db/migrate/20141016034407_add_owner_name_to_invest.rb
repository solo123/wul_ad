class AddOwnerNameToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :owner_name, :string, :default => ""
  end
end
