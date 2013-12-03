class FixedDepositsController < ResourcesController
  private
    def fixed_deposit_params
      params.require(:fixed_deposit).permit(:deposit_number, :total_amount, :annual_rate, :repayment_period, :guarantee, :free_invest_amount, :detail, :income_method, :join_date, :join_condition, :expiring_date, :repayment_method, :premature_redemption, :fee)
    end
end
