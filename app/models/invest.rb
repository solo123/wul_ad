class Invest < ActiveRecord::Base
  belongs_to :user_info
  belongs_to :product

  def refund
    refund_amount = self.amount
    account = self.user_info.account
    Transaction.createTransaction("principal", refund_amount, account.balance, account.balance + refund_amount, self.user_info.id, self.product.deposit_number, self.product_type)
    account.balance += refund_amount
    account.save!
  end



  def payprofit
    profit = self.calculate_profit
    balance = self.user_info.account.balance
    Transaction.createTransaction("profit", profit, balance, balance + profit, self.user_info.id, self.product.deposit_number, self.product_type)
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
    Transaction.createTransaction("principal", principal, balance, balance + principal, self.user_info.id, self.product.deposit_number, self.product_type)
    self.amount -= principal
    self.user_info.account.balance += principal
    self.user_info.account.save!
    self.save!
  end
end