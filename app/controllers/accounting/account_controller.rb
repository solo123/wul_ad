module Accounting
  class AccountController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def execute_cmd
      cmd = params[:op_action] + "_" + params[:op_name]
      res = send(cmd, params)
      # logger.info(res[:op_result])
      render :json => res
      # render :json => {:op_result => false, :op_result_code => 1}
    end

    def create_account(params)
      if AccountAccount.exists?(:uinfo_id => params[:uinfo_id])
        return {:op_result => false, :op_result_code => 1}
      else
        act = AccountAccount.new(:uinfo_id => params[:uinfo_id])
        exe_res = act.save!
        return {:op_result => exe_res, :op_result_code => 0}
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
      act = AccountAccount.where(:uinfo_id => params[:uinfo_id]).first
      if act
        act.balance += params[:op_amount].to_f
        act.save!
      else
        return {:op_result => false, :op_result_code => 3}
      end

      return {:op_result => true, :op_result_code => 0, :op_result_value => act.balance }
    end

    def sell_invest(params)
      return {:op_result => true, :op_result_code => 0}
    end

    def join_invest(params)
      product = AccountProduct.find_by deposit_number: params[:op_resource_name]
      account = AccountAccount.find_by uinfo_id: params[:uinfo_id]
      sub_invest = AccountSubInvest.new
      if product && account
        join_value = params[:op_amount].to_f

        if(join_value > account.balance)
          return {:op_result => false, :op_result_code => 5}
        end
        sub_product = account.account_sub_products.create_with(account_product_id: product.id).find_or_create_by(deposit_number: product.deposit_number)

        if (join_value + sub_product.total_amount > product.max_limit)
          return {:op_result => false, :op_result_code => 6}
        end

        sub_product.add_total_amount_save(join_value)
        account.reduce_balance(join_value, "join", product.deposit_number)

        sub_invest.account_sub_product = sub_product
        sub_invest.save_params(join_value, product)
      else
        return {:op_result => false, :op_result_code => 4}
      end
      return {:op_result => true, :op_result_code => 0, :op_result_value => account.balance, :op_asset_id => sub_invest.id}
    end


    def withdraw_account(params)

    end


  end

end
