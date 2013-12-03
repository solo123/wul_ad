json.array!(@photos) do |photo|
  json.extract! photo, :photo_data_type, :photo_data_id, :creator_id
  json.url photo_url(photo, format: :json)
end
