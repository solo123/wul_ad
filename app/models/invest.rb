class Invest < ActiveRecord::Base
	belongs_to :user_info
  attr_accessor :product
  def refund
    refund_amount = self.amount * self.product.annual_rate * 100 / 12 * product.repayment_period
    account = self.user_info.account
    trans = Transaction.new
    trans.trans_type = "refund"
    trans.account_before = account.balance
    trans.account_after =  account.balance + refund_amount
    trans.frozen_before = account.frozen_balance
    trans.operation_amount = refund_amount
    trans.frozen_after = trans.frozen_before
    account += refund_amount
    account.save!
    trans.save!
  end

  def product
    FixedDeposit.where(:deposit_number => self.loan_number).first
  end
end
