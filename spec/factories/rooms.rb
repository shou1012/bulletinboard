FactoryGirl.define do
  factory :room do
    sequence(:id) { |n| "id_#{n}" }
    name "room1"
    description "about room1"
    user_id 1
  end

  factory :comment  do
    sequence(:id) { |n| "id_#{n}" }
    text "comment about room1"
    user_id 1
    room

    end
end
