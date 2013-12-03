require 'test_helper'

class GuaranteeCompaniesControllerTest < ActionController::TestCase
  setup do
    @guarantee_company = guarantee_companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guarantee_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guarantee_company" do
    assert_difference('GuaranteeCompany.count') do
      post :create, guarantee_company: { company_id: @guarantee_company.company_id, invest_id: @guarantee_company.invest_id, report: @guarantee_company.report }
    end

    assert_redirected_to guarantee_company_path(assigns(:guarantee_company))
  end

  test "should show guarantee_company" do
    get :show, id: @guarantee_company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @guarantee_company
    assert_response :success
  end

  test "should update guarantee_company" do
    patch :update, id: @guarantee_company, guarantee_company: { company_id: @guarantee_company.company_id, invest_id: @guarantee_company.invest_id, report: @guarantee_company.report }
    assert_redirected_to guarantee_company_path(assigns(:guarantee_company))
  end

  test "should destroy guarantee_company" do
    assert_difference('GuaranteeCompany.count', -1) do
      delete :destroy, id: @guarantee_company
    end

    assert_redirected_to guarantee_companies_path
  end
end
