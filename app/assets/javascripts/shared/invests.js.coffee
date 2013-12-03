invest_calculate_each_repayment_amount = () ->
  $('#invest_each_repayment_amount').val('123123')

$(document).on 'click', 'button[data-calculate-rate]', ->
	invest_calculate_each_repayment_amount()
