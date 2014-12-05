class Product < ActiveRecord::Base
  attr_accessor :current_action, :current_operation, :current_stage, :display_action, :display_status, :current_profit, :profit_status, :profit_action
  before_create :add_profit_date
  after_create :create_agreement
  has_many :invests
  has_many :product_profits
  has_many :product_principals
  has_one :agreement
  belongs_to :person_info

  def send_account
    record = self.to_json(:only => [:deposit_number, :total_amount, :annual_rate, :repayment_period, :each_repayment_amount, :free_invest_amount,
                                    :fixed_invest_amount, :join_date, :expiring_date, :premature_redemption, :fee, :product_type, :stage, :profit_date,
                                    :principal_date, :status, :min_limit, :max_limit, :each_repayment_period, :join_date, :repayment_method])
    operation = AccountOperation.new(:op_name => "product", :op_action => "create", :op_obj => record, :op_id_head => "CP", :op_resource_name => self.
        deposit_number, :op_resource_id => self.id)
    operation.execute_transaction
  end


  def cal_pp_amount
   if self.repayment_method == "profit_principal"
     period_rate = self.annual_rate / 365 /100 * self.each_repayment_period
     self.fixed_pp_amount =  (self.fixed_invest_amount * period_rate * (1 + period_rate) ** self.repayment_period) / (((1 + period_rate) ** self.repayment_period) - 1)
     self.remain_principal = self.fixed_invest_amount
     self.period_rate = period_rate
   end
  end


  def create_agreement
    agree = Agreement.new
    agree.persona = "王潜行"
    agree.personb = "沃银金融"
    self.agreement = agree
    agree.save!
  end

  def add_profit_record(profit_amount, profit_number)
    product_profit = ProductProfit.new(:refund_amount => profit_amount, :refund_time => Time.now, :product_id => self.id)
    product_profit.profit_number = profit_number
    product_profit.save!
  end

  def add_principal_record(prin_amount, prin_number)
    product_principal = ProductPrincipal.new(:refund_amount => prin_amount, :refund_time => Time.now, :product_id => self.id)
    product_principal.principal_number = prin_number
    product_principal.save!
  end


  def add_profit_date
    self.profit_date = self.join_date
    self.principal_date = self.join_date
  end


  def current_profit
    if ["收益中", "待清算"].include?(self.stage)
      if self.has_profit?
        calculate_profit
      else
        0
      end
    else
      0
    end
  end

  def current_principal
    if ["收益中", "待清算"].include?(self.stage)
      if self.has_principal?
       return calculate_principal
      else
       return 0
      end
    else
      return 0
    end
    return 0
  end

  def calculate_principal
    if self.repayment_method == "profit" && self.last_profit_period?
      self.fixed_invest_amount
    elsif repayment_method == "profit_principal"
      # period_rate = self.product.each_repayment_period * self.annual_rate / 365 /100
      self.fixed_pp_amount - self.calculate_profit
      # self.fixed_pp_amount
    else
      0
    end
  end

  def calculate_profit
    if self.repayment_method == "profit"
      self.fixed_invest_amount * self.annual_rate * self.each_repayment_period / 365 / 100
    elsif self.repayment_method == "profit_principal"
      self.remain_principal * self.period_rate
    else
      0
    end
  end


  def current_stage

    if ["未发布", "入库中", "已入库", "融资中", "已结束"].include?(self.stage)
      return self.stage
    end

    if self.locked
      return "锁定中"
    end

    if self.over_time?
      "待清算"
    else
      self.stage
    end
  end



  def over_time?
    end_date = self.join_date + (self.each_repayment_period * self.repayment_period).days
    end_date < Date.today
  end

  def current_operation
    case self.current_stage
      when "未发布"
        "入库"
      when "入库中"
        "状态"
      when "已入库"
        "发布"
      when "融资中"
        "结束"
      when "收益中"
        "查看"
      when "待清算"
        if self.profit_cleared && self.principal_cleared
          "结束"
        else
          "查看"
        end
      when "已结束"
        "查看"
      when "锁定中"
        "查看"
    end
  end

  def current_action
    case self.current_stage
      when "未发布"
        "/products/#{self.product_type}/#{self.id}/exp_account"
      when "入库中"
        "#"
      when "已入库"
        "/products/#{self.product_type}/#{self.id}/publish"
      when "融资中"
        "/products/#{self.product_type}/#{self.id}/finish"
      when "收益中"
        "/products/#{self.product_type}/#{self.id}"
      when "待清算"
        if self.profit_cleared && self.principal_cleared
          "/products/#{self.product_type}/#{self.id}/clear"
        else
          "/products/#{self.product_type}/#{self.id}"
        end
      when "已结束"
        "/products/#{self.product_type}/#{self.id}"
      when "锁定中"
        "/products/#{self.product_type}/#{self.id}"
    end
  end

  def display_status
    if self.display == "hide"
      "显示"
    else
      "隐藏"
    end
  end

  def display_action
    "/products/#{self.product_type}/#{self.id}/switchdisplay"
  end

  def profit_action
    if self.profit_operation == "付息"
      "/products/#{self.product_type}/#{self.id}/payprofit"
    else
      # "/products/#{self.product_type}/#{self.id}/payprofit"
      "#"
    end
  end


  def pay_operation
    if self.principal_cleared && self.profit_cleared
      return "结毕"
    end

    if self.locked || !["收益中", "待清算"].include?(self.current_stage)
      return "暂无"
    end

    if self.has_profit? || self.has_principal?
      return "支付"
    end
    return "暂无"
  end

  def pay_action
    if self.pay_operation == "支付"
      "/products/#{self.product_type}/#{self.id}/payprincipal"
    else
      "#"
    end
  end


  def principal_action
    if self.principal_operation == "付本"
      "/products/#{self.product_type}/#{self.id}/payprincipal"
    else
      "#"
    end
  end

  def has_profit?
    end_date =self.join_date + (self.each_repayment_period * self.repayment_period).days
   (end_date < Date.today) && ( self.last_profit_date + self.each_repayment_period.days <= end_date)
  end

  def product_name
    dict = {"fixed" => "定存宝",
            "month" => "月月盈"}
    dict[self.product_type]
  end

  def principal_left?
    end_date =self.join_date + (self.each_repayment_period * self.repayment_period).days
    (end_date < Date.today) && ( self.last_principal_date + self.each_repayment_period.days <= end_date)
  end

  def has_principal?
    if self.principal_cleared
      return false
    end

    if self.stage == "结毕"
      return false
    end

    if self.repayment_method == "profit"
      return self.current_profit_period == self.repayment_period
    end

    if self.repayment_method == "profit_principal" && self.principal_left?
      return true
    end

    return false
  end


  def last_principal_period?
    end_date = self.join_date + (self.each_repayment_period * self.repayment_period).days
    self.last_principal_date + self.each_repayment_period.days >= end_date
  end

  def last_profit_period?
    end_date = self.join_date + (self.each_repayment_period * self.repayment_period).days
    self.last_profit_date + self.each_repayment_period.days >= end_date
  end
  #
  # def last_profit_date
  #   profits = self.product_profits
  #   if profits.size > 0
  #     return profits.last.refund_time
  #   else
  #     return self.join_date
  #   end
  # end

  def last_profit_date
    t = self.current_profit_period * self.each_repayment_period
    time = self.join_date + t.days
  end


  def last_principal_date
    t = self.current_principal_period * self.each_repayment_period
    time = self.join_date + t.days
  end


  def update_current_principal(principal)
    self.remain_principal -= principal
  end

end
