class AddPendingToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :pending_status, :boolean ,:default => false
  end
end
