class Invest < ActiveRecord::Base
  belongs_to :user_info
  attr_accessor :product
  def refund
    refund_amount = self.amount
    account = self.user_info.account
    Transaction.createTransaction("refunded", refund_amount, account.balance, account.balance + refund_amount, self.user_info.id, self.product.deposit_number)
    account.balance += refund_amount
    account.save!
  end

  def product
    if self.invest_type == "fixed"
      FixedDeposit.where(:deposit_number => self.loan_number).first
    elsif self.invest_type=="month"
      MonthDeposit.where(:deposit_number => self.loan_number).first
    end
  end

  def payprofit
    profit = (self.amount * self.product.annual_rate / 12 / 100).round(2)
    balance = self.user_info.account.balance
    Transaction.createTransaction("profit", profit, balance, balance + profit, self.user_info.id, self.product.deposit_number)
    self.user_info.account.balance += profit
    self.user_info.account.save!
    #puts self.profit_date
  end

  def pay_principal
    principal = (self.amount / self.product.repayment_period).round(2)
    balance = self.user_info.account.balance
    Transaction.createTransaction("principal", principal, balance, balance + principal, self.user_info.id, self.product.deposit_number)
    self.amount -= principal
    self.user_info.account.balance += principal
    self.user_info.account.save!
    self.save!
  end
end