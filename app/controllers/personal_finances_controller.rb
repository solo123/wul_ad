class PersonalFinancesController < ApplicationController
  before_action :set_personal_finance, only: [:show, :edit, :update, :destroy]

  # GET /personal_finances
  # GET /personal_finances.json
  def index
    @personal_finances = PersonalFinance.all
  end

  # GET /personal_finances/1
  # GET /personal_finances/1.json
  def show
  end

  # GET /personal_finances/new
  def new
    @personal_finance = PersonalFinance.new
  end

  # GET /personal_finances/1/edit
  def edit
  end

  # POST /personal_finances
  # POST /personal_finances.json
  def create
    @personal_finance = PersonalFinance.new(personal_finance_params)

    respond_to do |format|
      if @personal_finance.save
        format.html { redirect_to @personal_finance, notice: 'Personal finance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @personal_finance }
      else
        format.html { render action: 'new' }
        format.json { render json: @personal_finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_finances/1
  # PATCH/PUT /personal_finances/1.json
  def update
    respond_to do |format|
      if @personal_finance.update(personal_finance_params)
        format.html { redirect_to @personal_finance, notice: 'Personal finance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_finances/1
  # DELETE /personal_finances/1.json
  def destroy
    @personal_finance.destroy
    respond_to do |format|
      format.html { redirect_to personal_finances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_finance
      @personal_finance = PersonalFinance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_finance_params
      params.require(:personal_finance).permit(:user_info_id, :monthly_income, :dpi, :pcdi)
    end
end
