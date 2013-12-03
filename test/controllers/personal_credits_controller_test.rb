require 'test_helper'

class PersonalCreditsControllerTest < ActionController::TestCase
  setup do
    @personal_credit = personal_credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_credits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_credit" do
    assert_difference('PersonalCredit.count') do
      post :create, personal_credit: { credit_cards: @personal_credit.credit_cards, credit_utilization_rate: @personal_credit.credit_utilization_rate, other_credit: @personal_credit.other_credit }
    end

    assert_redirected_to personal_credit_path(assigns(:personal_credit))
  end

  test "should show personal_credit" do
    get :show, id: @personal_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_credit
    assert_response :success
  end

  test "should update personal_credit" do
    patch :update, id: @personal_credit, personal_credit: { credit_cards: @personal_credit.credit_cards, credit_utilization_rate: @personal_credit.credit_utilization_rate, other_credit: @personal_credit.other_credit }
    assert_redirected_to personal_credit_path(assigns(:personal_credit))
  end

  test "should destroy personal_credit" do
    assert_difference('PersonalCredit.count', -1) do
      delete :destroy, id: @personal_credit
    end

    assert_redirected_to personal_credits_path
  end
end
