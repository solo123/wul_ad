json.array!(@user_infos) do |user_info|
  json.extract! user_info, :show_id, :gender, :age, :birthday, :education, :education_from, :marital_status, :childs_status, :domiciliary_reg, :status
  json.url user_info_url(user_info, format: :json)
end
