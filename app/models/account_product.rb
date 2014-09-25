class AccountProduct < ActiveRecord::Base
  has_many :account_sub_products
  has_many :account_sub_invests
  def add_fixed_amount_save(join_value)
    self.fixed_invest_amount += join_value
    self.save!
  end
end
