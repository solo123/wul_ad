class CreateReqTable < ActiveRecord::Migration
  def change
    create_table :withdraw_requests do |t|
      t.integer :user_info_id
      t.string :bank_name
      t.string :bank_card_no
      t.integer :bankcard_id
      t.string :real_name
      t.integer :amount
      t.timestamps
    end
  end
end
