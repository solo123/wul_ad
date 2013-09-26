class RolesController < ResourcesController
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:role_name)
    end
end
