class UserInfo < ActiveRecord::Base
  has_many :invests
  has_many :transactions
  has_one :analyzer
  has_one :account, :dependent=>:destroy, :autosave=>true
  belongs_to :user
  has_one :verification
  has_one :delagator, :dependent=>:destroy, :autosave=>true

  after_create :create_delagator
  after_create :create_verification
	def showname
		"##{id} #{real_name}"
  end

  def create_verification
    vef = Verification.new
    self.verification = vef
    vef.save!
  end

  def create_delagator
    delagator = Delagator.new
    delagator.last_invest_time = delagator.last_open_time = Time.now
    self.delagator = delagator
    delagator.save!
  end
end
