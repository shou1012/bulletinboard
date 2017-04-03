
json.array!(@rooms) do |room|
  json.extract! product, :id, :name, :user_id, :description, :created_at, :updated_at,
  json.url room_url(room, format: :json)
end
