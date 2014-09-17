class AddParametersToSecure < ActiveRecord::Migration
  def change
    add_column :verifications, :phone_confirm_status, :boolean, :default => false
  end
end
