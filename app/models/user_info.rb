class UserInfo < ActiveRecord::Base
	has_many :invests
	def showname
		"##{id} #{real_name}"
	end
end
