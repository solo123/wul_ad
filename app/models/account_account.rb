class AccountAccount < ActiveRecord::Base
  has_many :account_sub_products
  def reduce_balance(amount, operation, obj)
    self.balance -= amount
    self.save!
  end

  def add_balance(amount, operation, obj)
    self.balance += amount
    self.save!
  end
end
