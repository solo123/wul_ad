##
# This file is auto-generated. DO NOT EDIT!
#

module Wul
  class User
    optional :string, :first_name, 1
    optional :string, :last_name, 2
  end



  ##
  # Service Classes
  #
  class UserService
    def find
      # request.email will be the unpacked string that was sent by the client request
      users = users_by_email.map(&:to_proto)
      respond_with(:users => users)
    end

    private

    def users_by_email
      User.find_by_email(request.email)
    end
  end

end
