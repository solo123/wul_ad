class ProductsController < ResourcesController
  def index
    pages = 20
    @collection = Product.where(:product_type => params[:product_type]).paginate(:page => params[:page], :per_page => pages)
    logger.info(params)
    render "products/"+params[:product_type]
  end

  def new
    @product = Product.new
    @product.product_type = params[:product_type]
  end


  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    params.permit!
    @product = Product.new(params[:product])
    if @product.save
      redirect_to show_product_path(@product.product_type, @product.id)
      #redirect_to "product/fixed" + @product.id
      return
    else
      flash[:error] = @product.errors.full_messages.to_sentence
      @no_log = 1
    end
    redirect_to :action => :new
  end


  def settle
    pages = 20
    @collection = Product.where(:product_type => params[:format]).paginate(:page => params[:page], :per_page => pages)
    #load_collection
  end

  def switchdisplay
    dep = FixedDeposit.find(params[:format])
    if dep.display == "show"
      dep.display = "hide"
    else
      dep.display = "show"
    end
    dep.save!
    redirect_to settle_fixed_deposits_path
  end

  def publish
    dep = FixedDeposit.find(params[:format])
    load_object
    dep.stage = "融资中"
    dep.display = "show"
    dep.save!
    redirect_to settle_fixed_deposits_path
  end

  def finish
    dep = FixedDeposit.find(params[:format])
    dep.stage = "收益中"
    dep.save!
    redirect_to settle_fixed_deposits_path
  end

  def refund
    dep = FixedDeposit.find(params[:format])
    if dep.current_profit >0
      Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.payprofit }
    end
    Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.refund }
    dep.stage = "已结束"
    dep.display ="hide"
    dep.save!
    redirect_to settle_fixed_deposits_path
  end

  def payprofit
    dep = FixedDeposit.find(params[:format])
    if dep.current_profit > 0
      Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.payprofit }
      dep.profit_date = dep.profit_date + 30.days
      dep.save!
    end
    redirect_to settle_fixed_deposits_path
  end



  def load_collection
    @q = object_name.classify.constantize.search(params[:q])
    pages = 20
    @collection = @q.result(distinct: true).paginate(:page => params[:page], :per_page => pages)
  end


  private
  def fixed_deposit_params
    params.require(:fixed_deposit).permit(:deposit_number, :total_amount, :annual_rate, :repayment_period, :guarantee, :free_invest_amount, :detail, :income_method, :order_amount, :join_date, :join_condition, :expiring_date, :repayment_method, :premature_redemption, :fee, :status)
  end
end
