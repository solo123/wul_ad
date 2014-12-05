class WithdrawRequestsController < ResourcesController
  # def list
  #   pages = 15
  #   @product = Product.find(params[:product_id])
  #   @invests = @product.invests.paginate(:page => params[:page], :per_page => pages)
  # end

  def index
     @requests = WithdrawRequest.all
  end

  def destroy
    load_object
    @object.destroy!
    redirect_to :action => :index
  end

  def confirm
    # confirm the withdraw request and pay money here
    redirect_to :action => :index
  end

end
