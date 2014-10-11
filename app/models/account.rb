class Account < ActiveRecord::Base
  belongs_to :user_info
  def add_balance(amount, operation, obj, inv_type)
    puts "amount of #{amount} add to account#{self.user_info.mobile}, current_balance is #{self.balance}"

    Transaction.createTransaction(operation, amount, self.balance, balance + amount, self.user_info.id, obj, inv_type)
    self.balance += amount
    self.save!
  end

  def payprofit
    profit = self.calculate_profit
    balance = self.user_info.account.balance
    Transaction.createTransaction("profit", profit, balance, balance + profit, self.user_info.id, self.product.deposit_number, self.invest_type)
    self.user_info.account.balance += profit
    self.user_info.account.save!
    #puts self.profit_date
  end


end
