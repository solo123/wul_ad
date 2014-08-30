# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = Employee.new
u.email = "dominic0312@126.com"
u.password = u.password_confirmation ="wqxyy1985"
u.save!

#
 0.upto(20) do |i|
   Product.create(deposit_number: "FX20140821" + i.to_s, total_amount: 120000, annual_rate:13, repayment_period: 3,
                       guarantee:"ICBC", free_invest_amount: 120000, detail:"no detail", income_method:"tax", join_date:"2014-08-11",
                      join_condition:"car", expiring_date:"2014-09-09",repayment_method:"bycash", premature_redemption:"yes",
                       fee:12, profit_date:"2014-08-11")
 end


0.upto(20) do |i|
  FixedDeposit.create(deposit_number: "FX20140821" + i.to_s, total_amount: 120000, annual_rate:13, repayment_period: 3,
                      guarantee:"ICBC", free_invest_amount: 120000, detail:"no detail", income_method:"tax", join_date:"2014-08-11",
                      join_condition:"car", expiring_date:"2014-09-09",repayment_method:"bycash", premature_redemption:"yes",
                      fee:12)

end

0.upto(20) do |i|
  MonthDeposit.create(deposit_number: "MO20140822" + i.to_s, transaction_number:"R00192704",
                      address:"福田区车公庙泰然工贸园", usage:"购买自用车", usage_detail:"购买详情",repayment_method:"bycash",
                      credit_level:"高级会员",annual_rate:13, amount: 120000, repayment_period: 3, each_repayment_amount:1200,
                      free_invest_amount: 120000,expiring_date:"2014-09-09", invest_end_date:"2014-09-10", remark:"no remakr",
                      guarantee:"ICBC", join_date:"2014-08-11"
                      )
end
