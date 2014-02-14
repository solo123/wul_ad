fun_mtr = (p, r, n) ->
	rr = r / 100 / 12
	rn = Math.pow(1 + rr, n)
	m = p * rr * rn / (rn - 1) 
	Math.round(m * 100) / 100

invest_calculate_each_repayment_amount = () ->
  amount = fun_mtr($('#invest_amount').val(), $('#invest_annual_rate').val(), $('#invest_repayment_period').val())
  $('#invest_each_repayment_amount').val(amount)


$(document).on 'click', 'button[data-calculate-rate]', ->
  invest_calculate_each_repayment_amount()
