class AddRepayDateToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :profit_date, :datetime
    add_column :invests, :principle_date, :datetime
  end
end
