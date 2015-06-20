require 'test_helper'

class CurrencyTransactionsControllerTest < ActionController::TestCase
  setup do
    @currency_transaction = currency_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currency_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create currency_transaction" do
    assert_difference('CurrencyTransaction.count') do
      post :create, currency_transaction: { date: @currency_transaction.date, description: @currency_transaction.description, sum: @currency_transaction.sum, type: @currency_transaction.type }
    end

    assert_redirected_to currency_transaction_path(assigns(:currency_transaction))
  end

  test "should show currency_transaction" do
    get :show, id: @currency_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @currency_transaction
    assert_response :success
  end

  test "should update currency_transaction" do
    patch :update, id: @currency_transaction, currency_transaction: { date: @currency_transaction.date, description: @currency_transaction.description, sum: @currency_transaction.sum, type: @currency_transaction.type }
    assert_redirected_to currency_transaction_path(assigns(:currency_transaction))
  end

  test "should destroy currency_transaction" do
    assert_difference('CurrencyTransaction.count', -1) do
      delete :destroy, id: @currency_transaction
    end

    assert_redirected_to currency_transactions_path
  end
end
