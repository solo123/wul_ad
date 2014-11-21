class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_info, :dependent=>:destroy, :autosave=>true
  after_create :create_userinfo

  def create_userinfo
    uinfo = UserInfo.new
    account = Account.new
    analyzer = Analyzer.new
    uinfo.account = account
    uinfo.analyzer = analyzer
    uinfo.show_id = self.username
    uinfo.payment_password = self.password
    self.user_info = uinfo
    account.save!
    uinfo.save!
  end
end
