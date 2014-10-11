class AddAssetIndexToInvest < ActiveRecord::Migration
  def change
    add_index :invests, :asset_id
  end
end
