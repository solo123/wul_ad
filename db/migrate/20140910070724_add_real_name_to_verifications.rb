class AddRealNameToVerifications < ActiveRecord::Migration
  def change
    add_column :verifications, :realname, :string
  end
end
