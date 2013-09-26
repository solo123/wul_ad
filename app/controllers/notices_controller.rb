class NoticesController < ResourcesController
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(:title, :content, :creator_id, :approval_id, :release_time, :expiration_time, :status)
    end
end
