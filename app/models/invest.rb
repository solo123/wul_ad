class Invest < ActiveRecord::Base
  belongs_to :user_info
  belongs_to :product

  def refund
    refund_amount = self.amount
    account = self.user_info.account
    Transaction.createTransaction("principal", refund_amount, account.balance, account.balance + refund_amount, self.user_info.id, self.product.deposit_number, self.invest_type)
    account.balance += refund_amount
    account.save!
  end



  def payprofit
    profit = self.calculate_profit
    balance = self.user_info.account.balance
    Transaction.createTransaction("profit", profit, balance, balance + profit, self.user_info.id, self.product.deposit_number, self.invest_type)
    self.user_info.account.balance += profit
    self.user_info.account.save!
    #puts self.profit_date
  end

  def calculate_profit
    (self.amount * self.annual_rate / 12 /100).round(2)
  end

  def pay_principal
    principal = (self.amount / self.product.repayment_period).round(2)
    balance = self.user_info.account.balance
    Transaction.createTransaction("principal", principal, balance, balance + principal, self.user_info.id, self.product.deposit_number, self.invest_type)
    self.amount -= principal
    self.user_info.account.balance += principal
    self.user_info.account.save!
    self.save!
  end

   def Invest.update_profits(profits)
     profits.each do |p|
       #puts p["account_sub_invest_id"]
       inv = Invest.find_by asset_id: p["account_sub_invest_id"]
       inv.update_profit(p)
     end
   end

   def update_profit(profit)
       amount = profit["refund_amount"].to_f
       new_profit = InvestProfit.new(:refund_amount => amount, :refund_time => Time.now, :invest_id => self.id)
       self.user_info.account.add_balance(amount, "profit", self.loan_number, self.invest_type)
       new_profit.save!
   end

end