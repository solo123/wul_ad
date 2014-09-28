class AddNotifyNumToUinfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :notify_num, :integer, :default => 0
  end
end
