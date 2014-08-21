class MonthDepositsController < ResourcesController
  def settle
    load_collection
  end

  def switchdisplay
    dep = MonthDeposit.find(params[:format])
    if dep.display == "show"
      dep.display = "hide"
    else
      dep.display = "show"
    end
    dep.save!
    redirect_to settle_month_deposits_path
  end

  def publish
    dep = MonthDeposit.find(params[:format])
    load_object
    dep.stage = "融资中"
    dep.display = "show"
    dep.save!
    redirect_to settle_month_deposits_path
  end

  def finish
    dep = MonthDeposit.find(params[:format])
    dep.stage = "收益中"
    dep.save!
    redirect_to settle_month_deposits_path
  end

  def refund
    dep = MonthDeposit.find(params[:format])
    Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.refund }
    dep.stage = "已结束"
    dep.save!
    redirect_to settle_month_deposits_path
  end

  def payprofit
    dep = MonthDeposit.find(params[:format])
    if dep.current_profit > 0
      Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.payprofit }
      dep.profit_date = dep.profit_date + 30.days
      dep.save!
    end
    redirect_to settle_month_deposits_path
  end

  def payprincipal
    dep = MonthDeposit.find(params[:format])
    if dep.current_principal > 0
      Invest.where(:loan_number => dep.deposit_number).each { |inv| inv.pay_principal }
      dep.principal_date = dep.principal_date + 30.days
      dep.save!
    end
    redirect_to settle_month_deposits_path
  end


  private
  def invest_params
    params.require(:month_deposit).permit(:deposit_number, :transaction_number, :address, :usage, :usage_detail, :credit_level, :annual_rate, :amount, :repayment_period, :repayment_method, :each_repayment_amount, :free_invest_amount, :invest_end_date, :remark, :status)
  end

end
