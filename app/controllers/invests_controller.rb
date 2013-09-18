class InvestsController < ResourcesController

  private
    def invest_params
      params.require(:invest).permit(:jkbh, :jybh, :dz, :jkyt, :jkytsm, :xydj, :nhll, :jkje, :hkqx, :hkfs, :mqhkje, :ktje, :jssj, :bz)
    end
end
