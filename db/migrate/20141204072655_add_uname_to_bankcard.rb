class AddUnameToBankcard < ActiveRecord::Migration
  def change
    add_column :bankcards, :user_info_id, :integer
    add_column :bankcards, :real_name, :string, :default => ""
  end
end
