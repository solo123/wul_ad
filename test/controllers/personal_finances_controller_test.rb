require 'test_helper'

class PersonalFinancesControllerTest < ActionController::TestCase
  setup do
    @personal_finance = personal_finances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_finances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_finance" do
    assert_difference('PersonalFinance.count') do
      post :create, personal_finance: { dpi: @personal_finance.dpi, monthly_income: @personal_finance.monthly_income, pcdi: @personal_finance.pcdi, user_info_id: @personal_finance.user_info_id }
    end

    assert_redirected_to personal_finance_path(assigns(:personal_finance))
  end

  test "should show personal_finance" do
    get :show, id: @personal_finance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_finance
    assert_response :success
  end

  test "should update personal_finance" do
    patch :update, id: @personal_finance, personal_finance: { dpi: @personal_finance.dpi, monthly_income: @personal_finance.monthly_income, pcdi: @personal_finance.pcdi, user_info_id: @personal_finance.user_info_id }
    assert_redirected_to personal_finance_path(assigns(:personal_finance))
  end

  test "should destroy personal_finance" do
    assert_difference('PersonalFinance.count', -1) do
      delete :destroy, id: @personal_finance
    end

    assert_redirected_to personal_finances_path
  end
end
