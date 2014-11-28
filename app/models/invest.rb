class Invest < ActiveRecord::Base
  belongs_to :user_info
  belongs_to :product
  has_many :invest_profits

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

   def Invest.update_profits(profits, profit_number)
     profits.each do |p|
       inv = Invest.find_by asset_id: p["account_sub_invest_id"]
       inv.update_profit(p, profit_number)
     end
   end


  def Invest.update_principals(principals, prin_number)
    principals.each do |p|
      inv = Invest.find_by asset_id: p["account_sub_invest_id"]
      inv.update_principal(p, prin_number)
    end
  end

   def update_profit(profit, profit_number)
       amount = profit["refund_amount"].to_f
       new_profit = InvestProfit.new(:refund_amount => amount, :refund_time => Time.now, :invest_id => self.id)
       new_profit.profit_number = profit_number
       self.user_info.account.add_balance(amount, "profit", self.loan_number, self.invest_type)
       new_profit.save!
   end

  def update_principal(profit, prin_number)
    amount = profit["refund_amount"].to_f
    new_principal = InvestPrincipal.new(:refund_amount => amount, :refund_time => Time.now, :invest_id => self.id)
    new_principal.principal_number = prin_number
    self.user_info.account.add_balance(amount, "principal", self.loan_number, self.invest_type)
    new_principal.save!
  end

end