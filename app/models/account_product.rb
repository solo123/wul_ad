class AccountProduct < ActiveRecord::Base
  has_many :account_sub_products
  has_many :account_sub_invests
end
