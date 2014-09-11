class AddUserInfoToAnalyzer < ActiveRecord::Migration
  def change
    add_column :analyzers, :user_info_id, :integer
  end
end
