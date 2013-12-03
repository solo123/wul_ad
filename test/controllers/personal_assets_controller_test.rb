require 'test_helper'

class PersonalAssetsControllerTest < ActionController::TestCase
  setup do
    @personal_asset = personal_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_asset" do
    assert_difference('PersonalAsset.count') do
      post :create, personal_asset: { car_property: @personal_asset.car_property, house_property: @personal_asset.house_property, housing_loan: @personal_asset.housing_loan, purchase_date: @personal_asset.purchase_date }
    end

    assert_redirected_to personal_asset_path(assigns(:personal_asset))
  end

  test "should show personal_asset" do
    get :show, id: @personal_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_asset
    assert_response :success
  end

  test "should update personal_asset" do
    patch :update, id: @personal_asset, personal_asset: { car_property: @personal_asset.car_property, house_property: @personal_asset.house_property, housing_loan: @personal_asset.housing_loan, purchase_date: @personal_asset.purchase_date }
    assert_redirected_to personal_asset_path(assigns(:personal_asset))
  end

  test "should destroy personal_asset" do
    assert_difference('PersonalAsset.count', -1) do
      delete :destroy, id: @personal_asset
    end

    assert_redirected_to personal_assets_path
  end
end
