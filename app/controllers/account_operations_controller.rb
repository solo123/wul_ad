class AccountOperationsController < ResourcesController
  private
  def account_operation_params
    params.require(:account_operation).permit(:op_id, :resource_name)
  end
end