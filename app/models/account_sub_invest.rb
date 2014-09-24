class AccountSubInvest < ActiveRecord::Base
  belongs_to :account_sub_product
  belongs_to :account_product
  def save_params(join_value, product)
    self.loan_number = product.deposit_number
    self.account_product_id = product.id
    self.amount = join_value
    self.save!
  end
end
