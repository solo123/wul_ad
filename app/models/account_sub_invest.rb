class AccountSubInvest < ActiveRecord::Base
  belongs_to :account_sub_product
  belongs_to :account_product
  def save_params(join_value, product)
    self.loan_number = product.deposit_number
    self.account_product_id = product.id
    self.amount = join_value
    self.save!
  end

  def process_profit(profits, rate)
    profit = AccountInvestProfit.new
    profit_amount = (rate * self.amount).round(2)
    profit.refund_amount = profit_amount
    profit.refund_time = Time.now
    profit.account_sub_invest_id = self.id
    #profit.save!
    profits << profit
    logger.info("the profit of #{self.loan_number} + with id#{self.id} is #{profit.refund_amount}")
  end
end
