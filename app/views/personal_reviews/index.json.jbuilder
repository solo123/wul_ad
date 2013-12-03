json.array!(@personal_reviews) do |personal_review|
  json.extract! personal_review, :user_info_id, :id_card_verify_date, :credit_report_date, :work_verify_date, :income_verify_date, :guarantee_institution_id
  json.url personal_review_url(personal_review, format: :json)
end
