class PayoutDebtsController < ApplicationController
  before_action :set_payout_debt, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]

  # GET /payout_debts
  # GET /payout_debts.json
  def index
    current_user
    if params[:type] == 'борг'.force_encoding(Encoding::UTF_8)
      @payout_debts = PayoutDebt.all.where debt_id: Debt.current_family_member_debts(@current_user)
    else
      @payout_debts = PayoutDebt.all.where debt_id: Debt.current_family_member_loans(@current_user)
    end
  end

  # GET /payout_debts/1
  # GET /payout_debts/1.json
  def show
  end

  # GET /payout_debts/new
  def new
    @payout_debt = PayoutDebt.new
  end

  # GET /payout_debts/1/edit
  def edit
  end

  # POST /payout_debts
  # POST /payout_debts.json
  def create
    @payout_debt = PayoutDebt.new(payout_debt_params)

    respond_to do |format|
      if @payout_debt.save
        format.html { redirect_to @payout_debt, notice: 'Payout dep was successfully created.' }
        format.json { render :show, status: :created, location: @payout_debt }
      else
        format.html { render :new }
        format.json { render json: @payout_debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payout_debts/1
  # PATCH/PUT /payout_debts/1.json
  def update
    respond_to do |format|
      if @payout_debt.update(payout_debt_params)
        format.html { redirect_to @payout_debt, notice: 'Payout debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @payout_debt }
      else
        format.html { render :edit }
        format.json { render json: @payout_debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payout_debts/1
  # DELETE /payout_debts/1.json
  def destroy
    @payout_debt.destroy
    respond_to do |format|
      format.html { redirect_to payout_debts_url, notice: 'Payout debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payout_debt
      @payout_debt = PayoutDebt.find(params[:id])
    end

  def set_variables
    @currencies = Currency.all
    @debts = Debt.current_family_member_debts(current_user)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payout_debt_params
      params.require(:payout_debt).permit(:sum, :exchange_rate, :debt_id, :currency_id)
    end
end
