class PersonalAssetsController < ApplicationController
  before_action :set_personal_asset, only: [:show, :edit, :update, :destroy]

  # GET /personal_assets
  # GET /personal_assets.json
  def index
    @personal_assets = PersonalAsset.all
  end

  # GET /personal_assets/1
  # GET /personal_assets/1.json
  def show
  end

  # GET /personal_assets/new
  def new
    @personal_asset = PersonalAsset.new
  end

  # GET /personal_assets/1/edit
  def edit
  end

  # POST /personal_assets
  # POST /personal_assets.json
  def create
    @personal_asset = PersonalAsset.new(personal_asset_params)

    respond_to do |format|
      if @personal_asset.save
        format.html { redirect_to @personal_asset, notice: 'Personal asset was successfully created.' }
        format.json { render action: 'show', status: :created, location: @personal_asset }
      else
        format.html { render action: 'new' }
        format.json { render json: @personal_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_assets/1
  # PATCH/PUT /personal_assets/1.json
  def update
    respond_to do |format|
      if @personal_asset.update(personal_asset_params)
        format.html { redirect_to @personal_asset, notice: 'Personal asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_assets/1
  # DELETE /personal_assets/1.json
  def destroy
    @personal_asset.destroy
    respond_to do |format|
      format.html { redirect_to personal_assets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_asset
      @personal_asset = PersonalAsset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_asset_params
      params.require(:personal_asset).permit(:house_property, :housing_loan, :purchase_date, :car_property)
    end
end
