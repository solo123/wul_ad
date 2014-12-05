class CreateAddDueDateToReq < ActiveRecord::Migration
  def change
    add_column :withdraw_requests, :due_date, :datetime
  end
end
