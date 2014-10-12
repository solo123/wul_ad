class Product < ActiveRecord::Base
  attr_accessor :current_action, :current_operation, :current_stage, :display_action, :display_status, :current_profit, :profit_status, :profit_action
  before_create :add_profit_date
  after_create :create_agreement
  has_many :invests
  has_many :product_profits
  has_one :agreement

  def send_account
    record = self.to_json(:only => [:deposit_number, :total_amount, :annual_rate, :repayment_period, :each_repayment_amount, :free_invest_amount,
                                    :fixed_invest_amount, :join_date, :expiring_date, :premature_redemption, :fee, :product_type, :stage, :profit_date,
                                    :principal_date, :status, :min_limit, :max_limit, :each_repayment_period, :join_date])
    operation = AccountOperation.new(:op_name => "product", :op_action => "create", :op_obj => record, :op_id_head => "CP", :op_resource_name => self.
        deposit_number, :op_resource_id => self.id)
    operation.execute_transaction
  end

  def create_agreement
    agree = Agreement.new
    agree.persona = "王潜行"
    agree.personb = "沃银金融"
    self.agreement = agree
    agree.save!
  end

  def add_profit_record(profit_amount)
    product_profit = ProductProfit.new(:refund_amount => profit_amount, :refund_time => Time.now, :product_id => self.id)
    product_profit.save!
  end


  def add_profit_date
    self.profit_date = self.join_date
    self.principal_date = self.join_date
  end


  def current_profit
    if  self.has_profit?
      calculate_profit
    else
      0
    end
  end

  def current_principal

    if self.repayment_method == "profit" && self.expiring_date < Time.now.yesterday && self.stage!="已结束"
      return self.fixed_invest_amount
    end

    if Time.now >= self.principal_date + self.each_repayment_period.days && self.repayment_method == "profit_principal"
      self.fixed_invest_amount / self.repayment_period
    else
      0
    end
  end


  # def update_stage
  #   if self.stage == "入库中"
  #     op = AccountOperation.where(:op_resource_id => self.id, :op_name => "product", :op_action => "create").first
  #     if op
  #       logger.info("result is #{op.op_result},#{op.op_resource_name}")
  #       if op.op_result
  #          self.stage = "已入库"
  #          self.save!
  #        end
  #     end
  #   end
  # end


  def calculate_profit
    self.fixed_invest_amount * self.annual_rate * self.each_repayment_period / 365 / 12 / 100
  end

  def profit_status
    if self.locked
      return "锁定中"
    end
    if current_profit > 0
      "待付息"
    else
      "无利息"
    end
  end

  def principle_status
    if current_principal > 0
      "待返本"
    else
      "无返本"
    end
  end

  def current_stage
    if self.locked
      return "锁定中"
    end
    if self.expiring_date < Time.now.yesterday && self.stage!="已结束"
      "已到期"
    else
      self.stage
    end
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
      when "已到期"
        "结款"
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
      when "已到期"
        "/products/#{self.product_type}/#{self.id}/refund"
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
      "/products/#{self.product_type}/#{self.id}/payprofit"
      # "#"
    end
  end

  def principal_operation
    if self.locked
      "暂无"
    else
      "付本"
    end
  end

  def profit_operation
    if self.locked || !self.has_profit?
      "暂无"
    else
      "付息"
    end
  end

  def principal_action
    "/products/#{self.product_type}/#{self.id}/payprincipal"
  end

  def has_profit?
    self.last_profit_date + self.each_repayment_period.days < Time.now
  end

  def last_profit_date
    profits = self.product_profits
    if profits.size > 0
      return profits.last.refund_time
    else
      return self.join_date
    end
  end


end
