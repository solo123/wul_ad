class AccountRecordsController < ResourcesController
  private
  def account_record_params
    params.require(:account_record).permit(:op_id, :resource_name)
  end
end