require 'test_helper'

class FixedDepositsControllerTest < ActionController::TestCase
  setup do
    @fixed_deposit = fixed_deposits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fixed_deposits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fixed_deposit" do
    assert_difference('FixedDeposit.count') do
      post :create, fixed_deposit: { annual_rate: @fixed_deposit.annual_rate, deposit_number: @fixed_deposit.deposit_number, detail: @fixed_deposit.detail, expiring_date: @fixed_deposit.expiring_date, fee: @fixed_deposit.fee, free_invest_amount: @fixed_deposit.free_invest_amount, guarantee: @fixed_deposit.guarantee, income_method: @fixed_deposit.income_method, join_condition: @fixed_deposit.join_condition, join_date: @fixed_deposit.join_date, premature_redemption: @fixed_deposit.premature_redemption, repayment_method: @fixed_deposit.repayment_method, repayment_period: @fixed_deposit.repayment_period, total_amount: @fixed_deposit.total_amount }
    end

    assert_redirected_to fixed_deposit_path(assigns(:fixed_deposit))
  end

  test "should show fixed_deposit" do
    get :show, id: @fixed_deposit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fixed_deposit
    assert_response :success
  end

  test "should update fixed_deposit" do
    patch :update, id: @fixed_deposit, fixed_deposit: { annual_rate: @fixed_deposit.annual_rate, deposit_number: @fixed_deposit.deposit_number, detail: @fixed_deposit.detail, expiring_date: @fixed_deposit.expiring_date, fee: @fixed_deposit.fee, free_invest_amount: @fixed_deposit.free_invest_amount, guarantee: @fixed_deposit.guarantee, income_method: @fixed_deposit.income_method, join_condition: @fixed_deposit.join_condition, join_date: @fixed_deposit.join_date, premature_redemption: @fixed_deposit.premature_redemption, repayment_method: @fixed_deposit.repayment_method, repayment_period: @fixed_deposit.repayment_period, total_amount: @fixed_deposit.total_amount }
    assert_redirected_to fixed_deposit_path(assigns(:fixed_deposit))
  end

  test "should destroy fixed_deposit" do
    assert_difference('FixedDeposit.count', -1) do
      delete :destroy, id: @fixed_deposit
    end

    assert_redirected_to fixed_deposits_path
  end
end
