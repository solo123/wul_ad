class PersonInfosController < ResourcesController
  # def list
  #   pages = 15
  #   @product = Product.find(params[:product_id])
  #   @invests = @product.invests.paginate(:page => params[:page], :per_page => pages)
  # end

  def index
     @persons = PersonInfo.all
  end

  def destroy
    load_object
    @object.destroy!
    redirect_to :action => :index
  end

end
