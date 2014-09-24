class AccountSubProduct < ActiveRecord::Base
  belongs_to :account_product
  belongs_to :account_account
  has_many :account_sub_invests

  def add_total_amount_save(join_value)
    self.total_amount += join_value
    self.save!
  end
end
