class AddMessageNumToUinfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :message_num, :integer, :default => 0
  end
end
