class AddUinfoIdToAcAc < ActiveRecord::Migration
  def change
    add_column :account_accounts, :uinfo_id, :integer
  end
end
