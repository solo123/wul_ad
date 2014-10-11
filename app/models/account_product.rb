class AccountProduct < ActiveRecord::Base
  has_many :account_sub_products
  has_many :account_sub_invests
  has_many :account_product_profits
  def add_fixed_amount_save(join_value)
    self.fixed_invest_amount += join_value
    self.save!
  end

  def has_profit?
    self.last_profit_date + self.each_repayment_period.days < Time.now
  end

  def last_profit_date
    profits = self.account_product_profits
    if profits.size > 0
      return profits.last.refund_time
    else
      return self.join_date
    end

  end

  def pay_profits
    invests = self.account_sub_invests
    invest_profits = []
    amount = self.fixed_invest_amount
    period_rate = self.each_repayment_period * self.annual_rate / 365 /100
    period_number = (Date.today - self.last_profit_date).to_i / self.each_repayment_period
    total_profit = amount * period_rate
    product_profit = AccountProductProfit.new(:refund_amount => total_profit, :account_product_id => self.id, :refund_time => Time.now )
    invests.each do |inv|
      inv.process_profit(invest_profits, period_rate)
    end
    jso = invest_profits.to_json(:only => [:refund_amount, :refund_time, :account_sub_invest_id])

    #product_profit.save!
    logger.info("last profit date is  #{self.last_profit_date}")
    logger.info("the profit list is #{invest_profits[0].refund_amount}")
    logger.info("the total profit is #{jso.to_s}")
    return jso
  end


end
