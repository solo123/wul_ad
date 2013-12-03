require 'test_helper'

class PersonalReviewsControllerTest < ActionController::TestCase
  setup do
    @personal_review = personal_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_review" do
    assert_difference('PersonalReview.count') do
      post :create, personal_review: { credit_report_date: @personal_review.credit_report_date, guarantee_institution_id: @personal_review.guarantee_institution_id, id_card_verify_date: @personal_review.id_card_verify_date, income_verify_date: @personal_review.income_verify_date, user_info_id: @personal_review.user_info_id, work_verify_date: @personal_review.work_verify_date }
    end

    assert_redirected_to personal_review_path(assigns(:personal_review))
  end

  test "should show personal_review" do
    get :show, id: @personal_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_review
    assert_response :success
  end

  test "should update personal_review" do
    patch :update, id: @personal_review, personal_review: { credit_report_date: @personal_review.credit_report_date, guarantee_institution_id: @personal_review.guarantee_institution_id, id_card_verify_date: @personal_review.id_card_verify_date, income_verify_date: @personal_review.income_verify_date, user_info_id: @personal_review.user_info_id, work_verify_date: @personal_review.work_verify_date }
    assert_redirected_to personal_review_path(assigns(:personal_review))
  end

  test "should destroy personal_review" do
    assert_difference('PersonalReview.count', -1) do
      delete :destroy, id: @personal_review
    end

    assert_redirected_to personal_reviews_path
  end
end
