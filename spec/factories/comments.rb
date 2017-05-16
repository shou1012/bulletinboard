FactoryGirl.define do
  factory :comment, class: Rooms do
    sequence(:id) { |n| }
    text "comment about room1"
    user_id 1
    room_id 1
  end
end
