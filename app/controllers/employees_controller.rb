class EmployeesController < ResourcesController
  private
    def employee_params
      params.require(:employee).permit(:login_name, :show_name, :email, :phone, :password, :password_confirmation)
    end
end
