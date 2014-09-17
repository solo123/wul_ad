module Accounting
  class AccountController < ApplicationController
    skip_before_filter :verify_authenticity_token
    def execute_cmd
       render :json => "helloworld"
    end

  end

end
