class Accounting::AccountOperation < ActiveRecord::Base
  require 'net/https'
  require 'json'
  require "uri"
  $dest_url = "http://127.0.0.1:3001/accounting/account/execute_cmd"

  def self.execute_transaction(op_name, op_amount, op_action, operator)
    uri = URI.parse($dest_url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    data= {:api_key => "secret", :op_name => op_name, :op_amount => op_amount, :op_action => op_action, :operator => operator}
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_result = JSON.parse response.body
    record(op_name, op_amount, op_action, operator, op_result)
  end


  def record(op_name, op_amount, op_action, operator, op_res)
    rec = Accounting::AccountOperation.new(:op_name => op_name, :op_action => op_action, :op_amount => op_amount, :operator => operator,
                                           :op_result_code => op_res["op_result_code"],:op_result => op_res["op_result"] )
    rec.save!
  end


end
