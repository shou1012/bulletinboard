FactoryGirl.define do
  factory :room do
    sequence(:id) { |n| }
    name "room1"
    description "about room1"
    user_id 1
  end
end
