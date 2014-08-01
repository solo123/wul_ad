class FixedDeposit < ActiveRecord::Base
  attr_accessor :current_action, :current_operation, :current_stage, :display_action, :display_status

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
        "/fixed_deposits/publish.#{self.id}"
      when "融资中"
        "/fixed_deposits/finish.#{self.id}"
      when "收益中"
        "/fixed_deposits/#{self.id}"
      when "已到期"
        "/fixed_deposits/refund.#{self.id}"
      when "已结束"
        "/fixed_deposits/refund.#{self.id}"
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
      "/fixed_deposits/switchdisplay.#{self.id}"
  end
end
