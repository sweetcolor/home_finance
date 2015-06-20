require 'test_helper'

class PayoutDepsControllerTest < ActionController::TestCase
  setup do
    @payout_dep = payout_deps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payout_debts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payout_dep" do
    assert_difference('PayoutDep.count') do
      post :create, payout_dep: { exchange_rate: @payout_dep.exchange_rate, sum: @payout_dep.sum }
    end

    assert_redirected_to payout_dep_path(assigns(:@payout_debt))
  end

  test "should show payout_dep" do
    get :show, id: @payout_debt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payout_debt
    assert_response :success
  end

  test "should update payout_dep" do
    patch :update, id: @payout_debt, payout_dep: { exchange_rate: @payout_debt.exchange_rate, sum: @payout_debt.sum }
    assert_redirected_to payout_dep_path(assigns(:@payout_debt))
  end

  test "should destroy payout_dep" do
    assert_difference('PayoutDep.count', -1) do
      delete :destroy, id: @payout_debt
    end

    assert_redirected_to payout_deps_path
  end
end
