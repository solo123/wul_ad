class Product < ActiveRecord::Base


  attr_accessor :current_action, :current_operation, :current_stage, :display_action, :display_status,  :current_profit, :profit_status, :profit_action
  before_create :add_profit_date
  has_many :invests

  def add_profit_date
    self.profit_date = self.join_date
    self.principal_date = self.join_date
  end


  def current_profit
    if Time.now >= self.profit_date + 30.days
      calculate_profit
    else
      0
    end
  end

  def current_principal
    if Time.now >= self.principal_date + 30.days
      self.total_amount / self.repayment_period
    else
      0
    end
  end


  def calculate_profit
    self.total_amount * self.annual_rate / 12 / 100
  end

  def profit_status
    if current_profit > 0
      "等待付息"
    else
      "无需利息"
    end
  end

  def current_stage
    if self.expiring_date < Time.now.yesterday && self.stage!="已结束"
      "已到期"
    else
      self.stage
    end
  end

  def current_operation
    case self.current_stage
      when "未发布"
        "发布"
      when "融资中"
        "结束"
      when "收益中"
        "查看"
      when "已到期"
        "结款"
      when "已结束"
        "查看"
    end
  end

  def current_action
    case self.current_stage
      when "未发布"
        "/products/#{self.product_type}/#{self.id}/publish"
      when "融资中"
        "/month_deposits/finish.#{self.id}"
      when "收益中"
        "/month_deposits/#{self.id}"
      when "已到期"
        "/month_deposits/refund.#{self.id}"
      when "已结束"
        "/month_deposits/refund.#{self.id}"
    end
  end

  def display_status
    if self.display == "hide"
      "显示产品"
    else
      "隐藏产品"
    end
  end

  def display_action
    "/products/#{self.product_type}/#{self.id}/switchdisplay"
  end

  def profit_action
    "/products/#{self.product_type}/#{self.id}/payprofit"
  end

  def principal_action
    "/month_deposits/payprincipal.#{self.id}"
  end
end
