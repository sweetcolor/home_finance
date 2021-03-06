# encoding: UTF-8
class DebtsController < ApplicationController
  before_action :set_debt, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.where type: params[:type]
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
    @debt.type = params[:type]
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(debt_params)
    @debt.status = false

    respond_to do |format|
      if @debt.save
        format.html { redirect_to @debt, notice: 'Debt was successfully created.' }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    def set_variables
      @give_loans =
        if params[:type].eql? 'позика'.force_encoding(Encoding::UTF_8)
          Account.current_family_member(current_user)
        else
          Account.not_current_family_member(current_user)
        end
      @borrow_debts = Account.all - @give_loans
      @currencies = Currency.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:total_sum, :debt_date, :partial_repay_date, :full_repay_date, :type,
                                   :borrow_debt_id, :currency_id, :give_loan_id)
    end
end
