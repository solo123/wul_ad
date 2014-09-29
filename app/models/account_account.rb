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


  def transfer_invest(seller, invest, amount)
    self.balance -= amount
    seller.balance += (amount - invest.account_product.fee)
    seller.withdraw_invest(invest)
    self.buyin_invest(invest)
    self.save!
    seller.save!
    invest.onsale = false
    invest.save!
  end


  def withdraw_invest(invest)
    sub_product = invest.account_sub_product
    if sub_product.account_sub_invests.size == 1
      sub_product.destroy!
    else
      sub_product.total_amount -= invest.amount
    end
    sub_product.save!
  end

  def unable_to_buy?(invest)
    sub_product = self.account_sub_products.find_by deposit_number: invest.loan_number
    if sub_product
      sub_product.total_amount + invest.amount > sub_product.account_product.max_limit
    else
      false
    end
  end

  def buyin_invest(invest)
    sub_product = self.account_sub_products.create_with(account_product_id: invest.account_product_id, total_amount: 0).find_or_create_by(deposit_number: invest.loan_number)
    invest.account_sub_product = sub_product
    sub_product.save!
  end


end
