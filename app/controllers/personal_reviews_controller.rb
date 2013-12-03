class PersonalReviewsController < ApplicationController
  before_action :set_personal_review, only: [:show, :edit, :update, :destroy]

  # GET /personal_reviews
  # GET /personal_reviews.json
  def index
    @personal_reviews = PersonalReview.all
  end

  # GET /personal_reviews/1
  # GET /personal_reviews/1.json
  def show
  end

  # GET /personal_reviews/new
  def new
    @personal_review = PersonalReview.new
  end

  # GET /personal_reviews/1/edit
  def edit
  end

  # POST /personal_reviews
  # POST /personal_reviews.json
  def create
    @personal_review = PersonalReview.new(personal_review_params)

    respond_to do |format|
      if @personal_review.save
        format.html { redirect_to @personal_review, notice: 'Personal review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @personal_review }
      else
        format.html { render action: 'new' }
        format.json { render json: @personal_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_reviews/1
  # PATCH/PUT /personal_reviews/1.json
  def update
    respond_to do |format|
      if @personal_review.update(personal_review_params)
        format.html { redirect_to @personal_review, notice: 'Personal review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_reviews/1
  # DELETE /personal_reviews/1.json
  def destroy
    @personal_review.destroy
    respond_to do |format|
      format.html { redirect_to personal_reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_review
      @personal_review = PersonalReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_review_params
      params.require(:personal_review).permit(:user_info_id, :id_card_verify_date, :credit_report_date, :work_verify_date, :income_verify_date, :guarantee_institution_id)
    end
end
