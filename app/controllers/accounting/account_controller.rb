module Accounting
  class AccountController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def execute_cmd
      cmd = params[:op_action] + "_" + params[:op_name]
      res = send(cmd, params)
      # logger.info(res[:op_result])
      if res
        render :json => res and return
      else
        render :json =>  {:op_result => false, :op_result_code => 8}
      end
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


    # self.onsale = true
    # self.resell_price = self.amount * (100 - rate) /100
    # self.discount_rate = rate
    # self.save!


    def onsale_invest(params)
      invest = AccountSubInvest.find(params[:op_asset_id]) rescue nil
      rate = params[:op_amount].to_f
      logger.info("asset id is #{params[:op_asset_id]}")
      if invest
         if invest.onsale
           return {:op_result => false, :op_result_code => 9}
         else
           invest.onsale = true
           invest.resell_price = invest.amount * (100 - rate) /100 - invest.account_product.fee
           invest.discount_rate = rate
           invest.save!
           return {:op_result => true, :op_result_code => 0, :op_result_value => invest.resell_price}
         end
      end
      return {:op_result => false, :op_result_code => 10}
    end


    def buy_invest(params)
      invest = AccountSubInvest.find(params[:op_asset_id]) rescue nil
      buyer_account = AccountAccount.find_by uinfo_id: params[:uinfo_id] rescue nil


      if invest
        amount = invest.resell_price
        seller_account = invest.account_sub_product.account_account
        if buyer_account.balance < amount
          return {:op_result => false, :op_result_code => 5}
        end

        if buyer_account.unable_to_buy?(invest)
          return {:op_result => false, :op_result_code => 7}
        end

        if invest.onsale
          buyer_account.transfer_invest(seller_account, invest, amount)
          return {:op_result => true, :op_result_code => 0, :op_result_value => buyer_account.balance, :op_result_value2 => seller_account.balance,
          :uinfo_id2 => seller_account.uinfo_id, :op_amount => amount}
        else
          return {:op_result => false, :op_result_code => 11}
        end
      end
      return {:op_result => false, :op_result_code => 10}
    end



    def profit_invest(params)
      product = AccountProduct.find_by deposit_number: params[:op_resource_name]
      if product
         if product.has_profit?
            profits = product.pay_profits
            return {:op_result => true, :op_result_code => 0, :op_obj => profits, :op_result_value => product.current_profit.round(2), :op_resource_name => product.deposit_number }
         else
           return {:op_result => false, :op_result_code => 12}
         end
      else
        return {:op_result => false, :op_result_code => 4}
      end
    end

    def principal_invest(params)
      product = AccountProduct.find_by deposit_number: params[:op_resource_name]
      if product
        if product.has_principal?
          principals = product.pay_principals
          return {:op_result => true, :op_result_code => 0, :op_obj => principals, :op_result_value => product.current_principal.round(2), :op_resource_name => product.deposit_number }
        else
          return {:op_result => false, :op_result_code => 12}
        end
      else
        return {:op_result => false, :op_result_code => 4}
      end

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
      amount = params[:op_amount].to_f
      if act
        act.balance += params[:op_amount].to_f
        act.save!
      else
        return {:op_result => false, :op_result_code => 3}
      end

      return {:op_result => true, :op_result_code => 0, :op_result_value => act.balance, :op_amount =>amount }
    end

    def join_invest(params)
      product = AccountProduct.find_by deposit_number: params[:op_resource_name]
      account = AccountAccount.find_by uinfo_id: params[:uinfo_id]
      if product && account
        join_value = params[:op_amount].to_f

        if join_value > account.balance
          return {:op_result => false, :op_result_code => 5}
        end

        sub_product = account.account_sub_products.create_with(account_product_id: product.id, total_amount: 0).find_or_create_by(deposit_number: product.deposit_number)

        if join_value + sub_product.total_amount > product.max_limit
          logger.info("join_vaule is :#{join_value},total_amount is : #{sub_product.total_amount}, maxlimit is:#{product.max_limit}")
          return {:op_result => false, :op_result_code => 6}
        end

        if join_value + product.fixed_invest_amount > product.total_amount
          return {:op_result => false, :op_result_code => 7}
        end

        sub_product.add_total_amount_save(join_value)
        product.add_fixed_amount_save(join_value)
        account.reduce_balance(join_value, "join", product.deposit_number)
        sub_invest = AccountSubInvest.new
        sub_invest.account_sub_product = sub_product
        sub_invest.save_params(join_value, product)
        return {:op_result => true, :op_result_code => 0, :op_result_value => account.balance, :op_asset_id => sub_invest.id, :op_amount => join_value}
      else
        return {:op_result => false, :op_result_code => 4}
      end
    end


    def withdraw_account(params)

    end


  end

end
