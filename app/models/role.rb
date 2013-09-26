class Role < ActiveRecord::Base
	has_and_belongs_to_many :employees
	def to_s
		self.role_name
	end
end
