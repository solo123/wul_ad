class InvestsController < ResourcesController
  def list
    pages = 15
    @product = Product.find(params[:product_id])
    @invests = @product.invests.paginate(:page => params[:page], :per_page => pages)
  end

  def userlist
    pages = 15
    @uinfo = UserInfo.find(params[:uinfo_id])
    @uid = @uinfo.user_id
    @invests = @uinfo.invests.paginate(:page => params[:page], :per_page => pages)
  end


  def resale
    pages = 15
    @invests = Invest.where(:stage => "confirming").paginate(:page => params[:page], :per_page => pages)
  end

  def resale_confirm
    invest = Invest.find(params[:invest_id])
    invest.stage = "onsale"
    invest.save!
    op = AccountOperation.new(:op_name => "invest", :op_action => "onsale", :operator => "system", :uinfo_id => invest.user_info.id,
                              :op_asset_id => invest.asset_id, :op_amount => invest.discount_rate, :op_resource_id => invest.id)
    op.execute_transaction
    redirect_to :action => :resale
  end


  def buy_back
    redirect_to :action => :resale
  end


  private
    def invest_params
      params.require(:month_deposit).permit(:deposit_number, :transaction_number, :address, :usage, :usage_detail, :credit_level, :annual_rate, :amount, :repayment_period, :repayment_method, :each_repayment_amount, :free_invest_amount, :invest_end_date, :remark, :status)
    end
end
