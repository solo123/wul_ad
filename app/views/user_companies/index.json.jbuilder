json.array!(@user_companies) do |user_company|
  json.extract! user_company, :income, :age_of_business, :place_of_business, :business_status, :shareholding_rate
  json.url user_company_url(user_company, format: :json)
end
