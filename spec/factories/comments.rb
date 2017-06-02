FactoryGirl.define do

  factory :comment  do
    sequence(:text) { |n| "comment about room#{n}" }
    user_id 1
    room
  end
  
end
