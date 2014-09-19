class AccountRecord < ActiveRecord::Base
  $dict = {"create" => "创建",
            "product" => "产品"}

  def op_name_cn
   if self.op_name
     $dict[self.op_name]
   end
  end

  def op_action_cn
    if self.op_action
      $dict[self.op_action]
    end
  end

  def op_result_cn
    if self.op_result
      $dict[self.op_result]
    else
      "无操作"
    end
  end



  def AccountRecord.build_product_record(name, action, op_id, obj)
    rec = AccountRecord.new
    rec.op_name = name
    rec.op_action = action
    rec.op_id = op_id
    rec.resource_name = obj.deposit_number
    rec.save!
  end
end