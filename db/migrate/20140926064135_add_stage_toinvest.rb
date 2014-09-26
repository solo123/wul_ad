class AddStageToinvest < ActiveRecord::Migration
  def change
    add_column :invests, :stage, :string, :default => "normal"
  end
end
