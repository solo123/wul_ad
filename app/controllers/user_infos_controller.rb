class UserInfosController < ResourcesController
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_info_params
      params.require(:user_info).permit( :gender, :age, :birthday, :education, :education_from, :marital_status, :childs_status, :domiciliary_reg, :status)
    end
end
