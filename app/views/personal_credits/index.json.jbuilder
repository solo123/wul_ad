json.array!(@personal_credits) do |personal_credit|
  json.extract! personal_credit, :other_credit, :credit_cards, :credit_utilization_rate
  json.url personal_credit_url(personal_credit, format: :json)
end
