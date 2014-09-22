class AccountProduct < ActiveRecord::Base
  has_many :account_sub_products
end
