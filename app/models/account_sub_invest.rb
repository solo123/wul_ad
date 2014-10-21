class AccountSubInvest < ActiveRecord::Base
  belongs_to :account_sub_product
  belongs_to :account_product
  def save_params(join_value, product)
    self.loan_number = product.deposit_number
    self.account_product_id = product.id
    self.amount = join_value
    # self.remain_principal = self.amount
    self.save!
  end

  def process_profit(profits, rate)
    profit = AccountInvestProfit.new
    profit_amount = (rate * self.amount).round(2)
    profit.refund_amount = profit_amount
    profit.refund_time = Time.now
    profit.account_sub_invest_id = self.id
    profit.save!
    self.account_sub_product.account_account.add_balance(profit_amount, "profit", self.loan_number)
    profits << profit
    logger.info("the profit of #{self.loan_number} + with id#{self.id} is #{profit.refund_amount}")
  end


  def process_principal(principals, period)

    principal = AccountInvestPrincipal.new
    principal_amount = (self.amount / period).round(2)
    principal.refund_amount = principal_amount
    principal.refund_time = Time.now
    principal.account_sub_invest_id = self.id
    principal.save!

     self.account_sub_product.account_account.add_balance(principal_amount, "principal", self.loan_number)

    principals << principal
    # logger.info("the principal of #{self.loan_number} + with id#{self.id} is #{principal.refund_amount}")
  end

end
