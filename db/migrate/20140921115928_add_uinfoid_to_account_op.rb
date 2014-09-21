class AddUinfoidToAccountOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :user_info_id, :integer
    add_column :account_operations, :uinfo_id, :integer
  end
end
