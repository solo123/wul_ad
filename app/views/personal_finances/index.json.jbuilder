json.array!(@personal_finances) do |personal_finance|
  json.extract! personal_finance, :user_info_id, :monthly_income, :dpi, :pcdi
  json.url personal_finance_url(personal_finance, format: :json)
end
