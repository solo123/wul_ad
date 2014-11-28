class ProductsController < ResourcesController
  def index
    pages = 20
    @collection = Product.where(:product_type => params[:product_type], :status => 0).paginate(:page => params[:page], :per_page => pages)
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
      redirect_to show_products_path(@product.product_type, @product.id)
      #redirect_to "product/fixed" + @product.id
      return
    else
      flash[:error] = @product.errors.full_messages.to_sentence
      @no_log = 1
    end
    redirect_to :action => :new
  end

  def edit
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @product = Product.find(params[:id])
    params.permit!
    @product.attributes = params[:product]
    if @product.changed_for_autosave?
      #@changes = @object.all_changes
      if @product.save
      else
        flash[:error] = product.errors.full_messages.to_sentence
        @no_log = 1
      end
    end
    respond_to do |format|
      format.html { redirect_to :action => :show }
    end
  end


  def destroy
    @product = Product.find(params[:id])
    if @product.status && @product.status == 0
      @product.status = 7
    end
    @product.save
    redirect_to index_products_path(@product.product_type)
  end


  def settle
    pages = 20
    @collection = Product.where(:product_type => params[:product_type], :status => 0).order('created_at DESC').paginate(:page => params[:page], :per_page => pages)
    @product_type = params[:product_type]
  end

  def switchdisplay
    dep = Product.find(params[:id])
    if dep.display == "show"
      dep.display = "hide"
    else
      dep.display = "show"
    end
    dep.save!
    redirect_to settle_products_path(dep.product_type)
  end

  def exp_account
    @product = Product.find(params[:id])
    @product.send_account
    @product.stage = "入库中"
    @product.save!
    redirect_to settle_products_path(@product.product_type)
  end

  def publish
    @product = Product.find(params[:id])
    @product.stage = "融资中"
    @product.display = "show"
    @product.save!
    redirect_to settle_products_path(@product.product_type)
  end

  def finish
    dep = Product.find(params[:id])
    dep.stage = "收益中"
    dep.cal_pp_amount
    dep.save!
    redirect_to settle_products_path(dep.product_type)
  end

  def clear
    dep = Product.find(params[:id])
    dep.stage = "已结束"
    dep.save!
    redirect_to settle_products_path(dep.product_type)
  end


  def refund
    dep = Product.find(params[:id])
    invests = dep.invests
    if dep.current_profit >0
      invests.each { |inv| inv.payprofit }
    end
    invests.each { |inv| inv.refund }
    dep.stage = "已结束"
    #dep.display ="hide"
    dep.save!
    redirect_to settle_products_path(dep.product_type)
  end

  def payprofit
    dep = Product.find(params[:id])
    # if dep.current_profit > 0 && !dep.locked
    if !dep.locked
      op = AccountOperation.new(:op_name => "invest", :op_action => "profit", :operator => "system",
                                :op_resource_name => dep.deposit_number)
      op.op_id_head = "FX"
      op.execute_transaction
      dep.locked = true
      dep.save!
      # dep.invests.each { |inv| inv.payprofit }
      # dep.profit_date = dep.profit_date + dep.each_repayment_period.days
      # dep.save!
    end
    redirect_to settle_products_path(dep.product_type)
  end

  def payprincipal
    dep = Product.find(params[:id])

    if !dep.locked
      if dep.has_profit?
        op = AccountOperation.new(:op_name => "invest", :op_action => "profit", :operator => "system",
                                  :op_resource_name => dep.deposit_number)
        op.op_id_head = "FX"
        op.execute_transaction
        dep.locked = true
        dep.save!
      end

      if dep.has_principal?
        op = AccountOperation.new(:op_name => "invest", :op_action => "principal", :operator => "system",
                                  :op_resource_name => dep.deposit_number)
        op.op_id_head = "FB"
        op.execute_transaction
        dep.locked = true
        dep.save!
      end
    end
    redirect_to settle_products_path(dep.product_type)
  end


  # private
  # def fixed_deposit_params
  #   params.require(:fixed_deposit).permit(:deposit_number, :total_amount, :annual_rate, :repayment_period, :guarantee, :free_invest_amount, :detail, :income_method, :order_amount, :join_date, :join_condition, :expiring_date, :repayment_method, :premature_redemption, :fee, :status)
  # end
end
