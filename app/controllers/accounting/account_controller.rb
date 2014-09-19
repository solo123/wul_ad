module Accounting
  class AccountController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def execute_cmd
      cmd = params[:op_action] + "_" + params[:op_name]
      res = send(cmd, params)
      # logger.info(res[:op_result])
      render :json => {:op_result => res[:op_result], :op_result_code => res[:op_result_code], :op_result_value => res[:op_result_value]}
      # render :json => {:op_result => false, :op_result_code => 1}
    end

    def create_account(params)
      if Account.exists?(:user_id => params[:user_id])
        return {:op_result => false, :op_result_code => 2}
      else
        act = Account.new(:user_id => params[:user_id])
        exe_res = act.save!
        return {:op_result => exe_res, :op_result_code => 1, :op_result_value => act.id}
      end
    end

    def get_records(params)
      if Account.exists?(:user_id => params[:user_id])
        return {:op_result => false, :op_result_code => 1}
      else
        act = Account.new(:user_id => params[:user_id])
        if act.save!
          return {:op_result => true, :op_result_code => 0}
        else
          return {:op_result => false, :op_result_code => 1}
        end
      end
    end

    def create_invest(params)

    end

    def transfer_invest(params)

    end

    def profit_invest(params)

    end

    def principal_invest(params)

    end

    def create_product(params)
      product = JSON.parse params[:op_obj]
      operation_id = params[:operation_id]
      record = AccountProduct.new(product)
      if AccountProduct.exists?(:deposit_number => record.deposit_number)
        return {:op_result => false, :op_result_code => 1}
      end
      if record.save!
        rec = AccountRecord.build_product_record("product", "create", operation_id, record)
        return {:op_result => true, :op_result_code => 0}
      else
        return {:op_result => false, :op_result_code => 2}
      end
    end

    def charge_account(params)

    end

    def withdraw_account(params)

    end


  end

end
