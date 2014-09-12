class UserInfo < ActiveRecord::Base
  has_many :invests
  has_many :transactions
  has_one :analyzer
  has_one :account, :dependent=>:destroy, :autosave=>true
  belongs_to :user
	def showname
		"##{id} #{real_name}"
	end
end
