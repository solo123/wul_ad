class PersonalCreditsController < ApplicationController
  before_action :set_personal_credit, only: [:show, :edit, :update, :destroy]

  # GET /personal_credits
  # GET /personal_credits.json
  def index
    @personal_credits = PersonalCredit.all
  end

  # GET /personal_credits/1
  # GET /personal_credits/1.json
  def show
  end

  # GET /personal_credits/new
  def new
    @personal_credit = PersonalCredit.new
  end

  # GET /personal_credits/1/edit
  def edit
  end

  # POST /personal_credits
  # POST /personal_credits.json
  def create
    @personal_credit = PersonalCredit.new(personal_credit_params)

    respond_to do |format|
      if @personal_credit.save
        format.html { redirect_to @personal_credit, notice: 'Personal credit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @personal_credit }
      else
        format.html { render action: 'new' }
        format.json { render json: @personal_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_credits/1
  # PATCH/PUT /personal_credits/1.json
  def update
    respond_to do |format|
      if @personal_credit.update(personal_credit_params)
        format.html { redirect_to @personal_credit, notice: 'Personal credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_credits/1
  # DELETE /personal_credits/1.json
  def destroy
    @personal_credit.destroy
    respond_to do |format|
      format.html { redirect_to personal_credits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_credit
      @personal_credit = PersonalCredit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_credit_params
      params.require(:personal_credit).permit(:other_credit, :credit_cards, :credit_utilization_rate)
    end
end
