class AddDefaultStatusToDelag < ActiveRecord::Migration
  def change
    add_column :delagators, :status, :integer, :default => 0
  end
end
