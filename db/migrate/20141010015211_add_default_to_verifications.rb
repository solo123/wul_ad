class AddDefaultToVerifications < ActiveRecord::Migration
  def change
    change_column :verifications, :phonestatus, :string, :default => "confirming"
    change_column :verifications, :emailstatus, :string, :default => "confirming"
    change_column :verifications, :idstatus, :string, :default => "confirming"
  end
end
