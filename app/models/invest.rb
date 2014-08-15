class Invest < ActiveRecord::Base
	belongs_to :user_info
  attr_accessor :product
  def refund
    refund_amount = self.amount
    account = self.user_info.account
    Transaction.createTransaction("refund", refund_amount, account.balance, account.balance + refund_amount, self.user_info.id, self.id)
    account.balance += refund_amount
    account.save!
  end

  def product
    FixedDeposit.where(:deposit_number => self.loan_number).first
  end

  def payprofit
    profit = (self.amount * self.product.annual_rate / 12 / 100).round(2)
    balance = self.user_info.account.balance
    Transaction.createTransaction("profit", profit, balance, balance + profit, self.user_info.id, self.product.deposit_number)
    self.user_info.account.balance += profit
    self.user_info.account.save!
    #puts self.profit_date
  end
end
