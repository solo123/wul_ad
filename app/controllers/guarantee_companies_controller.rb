class GuaranteeCompaniesController < ApplicationController
  before_action :set_guarantee_company, only: [:show, :edit, :update, :destroy]

  # GET /guarantee_companies
  # GET /guarantee_companies.json
  def index
    @guarantee_companies = GuaranteeCompany.all
  end

  # GET /guarantee_companies/1
  # GET /guarantee_companies/1.json
  def show
  end

  # GET /guarantee_companies/new
  def new
    @guarantee_company = GuaranteeCompany.new
  end

  # GET /guarantee_companies/1/edit
  def edit
  end

  # POST /guarantee_companies
  # POST /guarantee_companies.json
  def create
    @guarantee_company = GuaranteeCompany.new(guarantee_company_params)

    respond_to do |format|
      if @guarantee_company.save
        format.html { redirect_to @guarantee_company, notice: 'Guarantee company was successfully created.' }
        format.json { render action: 'show', status: :created, location: @guarantee_company }
      else
        format.html { render action: 'new' }
        format.json { render json: @guarantee_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guarantee_companies/1
  # PATCH/PUT /guarantee_companies/1.json
  def update
    respond_to do |format|
      if @guarantee_company.update(guarantee_company_params)
        format.html { redirect_to @guarantee_company, notice: 'Guarantee company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guarantee_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guarantee_companies/1
  # DELETE /guarantee_companies/1.json
  def destroy
    @guarantee_company.destroy
    respond_to do |format|
      format.html { redirect_to guarantee_companies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guarantee_company
      @guarantee_company = GuaranteeCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guarantee_company_params
      params.require(:guarantee_company).permit(:invest_id, :company_id, :report)
    end
end
