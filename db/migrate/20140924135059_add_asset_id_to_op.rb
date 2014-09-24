class AddAssetIdToOp < ActiveRecord::Migration
  def change
    add_column :account_operations, :op_asset_id, :integer
  end
end
