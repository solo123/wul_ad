class UsersController < ResourcesController
  def index
    pages = 20
    @collection = User.where(:status => 0).paginate(:page => params[:page], :per_page => pages)
    render "index"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:role_name)
    end
end
