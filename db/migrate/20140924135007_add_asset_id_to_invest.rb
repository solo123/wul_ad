class AddAssetIdToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :asset_id, :integer
  end
end
