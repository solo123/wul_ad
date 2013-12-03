class InvestsController < ResourcesController

  private
    def invest_params
      params.require(:invest).permit(:loan_number, :transaction_number, :address, :usage, :usage_detail, :credit_level, :annual_rate, :amount, :repayment_period, :repayment_method, :each_repayment_amount, :free_invest_amount, :invest_end_date, :remark, :status)
		end
end
