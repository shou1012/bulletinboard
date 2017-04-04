json.data do |json|
  json.rooms_name @rooms.name
  json.rooms_description @rooms.description
  json.id @room.id
  json.created_at @room.created_at
  json.updated_at @room.updated_at
  json.user_id @room.user_id
end
