json.array!(@personal_assets) do |personal_asset|
  json.extract! personal_asset, :house_property, :housing_loan, :purchase_date, :car_property
  json.url personal_asset_url(personal_asset, format: :json)
end
