json.array!(@guarantee_companies) do |guarantee_company|
  json.extract! guarantee_company, :invest_id, :company_id, :report
  json.url guarantee_company_url(guarantee_company, format: :json)
end
