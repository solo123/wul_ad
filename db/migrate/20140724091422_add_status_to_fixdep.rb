class AddStatusToFixdep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :status, :integer, :default => 0
  end
end
