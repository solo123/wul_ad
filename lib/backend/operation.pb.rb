##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'
require 'protobuf/rpc/service'

module Backend

  ##
  # Message Classes
  #
  class Operation < ::Protobuf::Message; end
  class Result < ::Protobuf::Message; end


  ##
  # Message Fields
  #
  class Operation
    required :string, :action, 1
    required :float, :actionvalue, 2
    required :int32, :operator, 3
    required :int32, :account, 4
  end

  class Result
    required :string, :resultcode, 1
    required :string, :errorcode, 2
  end


  ##
  # Service Classes
  #
  class OperationService < ::Protobuf::Rpc::Service
    rpc :execute, ::Backend::Operation, ::Backend::Result
  end

end

