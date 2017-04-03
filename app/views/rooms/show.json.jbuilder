json.post do |json|
  json.title @rooms.name
  json.body @rooms.description
end
