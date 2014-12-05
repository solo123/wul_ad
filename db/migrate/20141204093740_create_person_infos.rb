class CreatePersonInfos < ActiveRecord::Migration
  def change
    create_table :person_infos do |t|
      t.integer :product_id
      t.string :gender, default: '男'
      t.integer :age, default: 35
      t.string :education, default: '大专'
      t.string :name, default: ''
      t.string :id_card_no, default: ''
      t.string :marrige, default: '已婚'
      t.string :children, default: '有'
      t.string :city, default: '广东省深圳市'
      t.string :income, default: '5000-8000'
      t.string :real_estate, default: '无'
      t.string :car, default: '无'
      t.string :other_debit, default: '无'
      t.string :work_city, default: '广东省深圳市'
      t.datetime :work_start_date
      t.string :industry, default: '房地产业'
      t.string :company_type, default: '民营'
      t.string :position, default: '客户经理'
      t.integer :total_history_amount, default: 0
      t.integer :due_amount, default: 0
      t.integer :over_time_amount, default: 0
      t.integer :danger_amount, default: 0
      t.integer :total_history_times, default: 0
      t.integer :due_times, default: 0
      t.integer :over_time_times, default: 0
      t.integer :danger_times, default: 0
      t.timestamps
    end
  end
end
