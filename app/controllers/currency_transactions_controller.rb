class CurrencyTransactionsController < ApplicationController
  before_action :set_currency_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update, :index]

  # GET /currency_transactions
  # GET /currency_transactions.json
  def index
    @currency_transactions = CurrencyTransaction.all.where account_id: Account.current_family_member(current_user)
    if (params[:category].present?) && (not params[:category][:id].blank?)
      category = Category.find(params[:category][:id])
      @type = category.type
      @currency_transactions = @currency_transactions.where(type: @type, category_id: Category.child_categories(category))
    else
      @type = params[:type] || params[:category][:type]
      @currency_transactions = @currency_transactions.where(type: @type)
    end
    @total_sum = @currency_transactions.sum :sum
  end

  # GET /currency_transactions/1
  # GET /currency_transactions/1.json
  def show
    # @currency_transaction = complete_record([@currency_transaction]).at(0)
  end

  # GET /currency_transactions/new
  def new
    @currency_transaction = CurrencyTransaction.new
    @currency_transaction.type = params[:type]
  end

  # GET /currency_transactions/1/edit
  def edit
  end

  # POST /currency_transactions
  # POST /currency_transactions.json
  def create
    @currency_transaction = CurrencyTransaction.new(currency_transaction_params)

    respond_to do |format|
      if @currency_transaction.save
        format.html { redirect_to @currency_transaction, notice: 'Currency transaction was successfully created.' }
        format.json { render :show, status: :created, location: @currency_transaction }
      else
        format.html { render :new }
        format.json { render json: @currency_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currency_transactions/1
  # PATCH/PUT /currency_transactions/1.json
  def update
    respond_to do |format|
      if @currency_transaction.update(currency_transaction_params)
        format.html { redirect_to @currency_transaction, notice: 'Currency transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency_transaction }
      else
        format.html { render :edit }
        format.json { render json: @currency_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currency_transactions/1
  # DELETE /currency_transactions/1.json
  def destroy
    @currency_transaction.destroy
    respond_to do |format|
      format.html { redirect_to currency_transactions_url, notice: 'Currency transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency_transaction
      @currency_transaction = CurrencyTransaction.find(params[:id])
    end

    def set_variables
      @categories = Category.all
      @accounts = Account.current_family_member(current_user)
    end

    def complete_record(array_records)
      result_array = array_records.map { |rec| rec.slice :date, :sum, :description, :type, :category_id, :account_id,
                                                         :currency_id }
      result_array.each do |record|
        record[:category] = Category.find(record[:category_id]).name
        record[:account] = Account.find(record[:account_id]).name
        record[:currency] = Currency.find(record[:currency_id]).name
      end
      result_array
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_transaction_params
      params.require(:currency_transaction).permit(:date, :sum, :description, :type, :category_id, :account_id,
                                                   :currency_id)
    end
end
