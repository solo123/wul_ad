class Transaction < ActiveRecord::Base
  belongs_to :user_info
  after_save :modify_analyzer

  def Transaction.createTransaction(transtype, amount, amount_before, amount_after, userid, investid, product_type)
    trans= Transaction.new
    trans.trans_type = transtype
    trans.operation_amount = amount
    trans.account_before = amount_before
    trans.account_after = amount_after
    trans.deposit_number = investid
    trans.user_info_id = userid
    trans.product_type = product_type
    trans.save!
    trans.create_notify
  end

  def modify_analyzer
    case self.trans_type
      when "profit"
        add_analyzer_data("total_profit")
      when "principal"
        add_analyzer_data("total_principal")
      else
    end
  end


  def create_notify
    message = Message.new()
    case self.trans_type
      when "profit"
        message.title = "利息到帐"
        message.content = "您在产品#{self.deposit_number}的投资于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")},产生#{self.operation_amount.round(2)}元的利息, 已经到您的账户中."

      when "principal"
        message.title = "本金回款"
        message.content = "您投资在产品#{self.deposit_number}的本金, 于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")},回款#{self.operation_amount.round(2)}元, 已经到您的账户中."
      else
    end
    message.user_info_id = self.user_info_id
    message.save!
  end

  def add_analyzer_data(field)
    if uinfo = UserInfo.find(self.user_info_id)
      a = uinfo.analyzer.product(self.product_type)
      a.send(field + '=', a.send(field) + self.operation_amount)
      a.save!
    end
  end

end
