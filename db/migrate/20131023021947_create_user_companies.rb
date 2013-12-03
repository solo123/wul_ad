class CreateUserCompanies < ActiveRecord::Migration
  def change
    create_table :user_companies do |t|
			t.integer :user_info_id
      t.decimal :income
      t.string :age_of_business
      t.string :place_of_business
      t.string :business_status
      t.string :shareholding_rate

      t.timestamps
    end
  end
end
