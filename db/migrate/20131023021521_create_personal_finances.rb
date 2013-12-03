class CreatePersonalFinances < ActiveRecord::Migration
  def change
    create_table :personal_finances do |t|
      t.integer :user_info_id
      t.decimal :monthly_income
      t.decimal :dpi
      t.decimal :pcdi

      t.timestamps
    end
  end
end
