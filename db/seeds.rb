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
 0.upto(5) do |i|
   Product.create(deposit_number: "FX20140821" + i.to_s, total_amount: 120000, annual_rate:13, repayment_period: 3,
                       guarantee:"ICBC", free_invest_amount: 120000, detail:"no detail", income_method:"tax", join_date:"2014-08-11",
                      join_condition:"car", expiring_date:"2014-09-09",repayment_method:"bycash", premature_redemption:"yes",
                       fee:12, profit_date:"2014-08-11", principal_date:"2014-08-11", each_repayment_period:6)
 end




