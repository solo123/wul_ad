class AddPasswdToVerify < ActiveRecord::Migration
  def change
    add_column :verifications, :passwd, :string
  end
end
