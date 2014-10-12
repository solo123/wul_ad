class AccountWorker
  include Sidekiq::Worker
  require "uri"
  def perform(url, data, record_id)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_res = JSON.parse response.body
    record = AccountOperation.find(record_id)
     logger.info(op_res)
    record.fill_params(op_res)
    if op_res["op_obj"]
      record.execute_update(op_res["op_obj"])
    else
      record.attach_action
    end
    record.save!
  end
end