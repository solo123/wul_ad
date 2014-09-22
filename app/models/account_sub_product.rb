class AccountSubProduct < ActiveRecord::Base
  belongs_to :account_product
  belongs_to :account_account
  has_many :account_sub_invests
end
