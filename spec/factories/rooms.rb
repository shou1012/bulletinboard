FactoryGirl.define do

  factory :comment  do
    sequence(:text) { |n| "comment about room#{n}" }
    user_id 1
    room
  end

  factory :room do
    sequence(:name) { |n| "room name#{n}" }
    sequence(:description) { |n| "about room#{n}" }
    user_id 1

    factory :room_with_comments do
      # 作成したいコメントの個数
      ignore do
        comments_count 5
      end

      after(:create) do |room, evaluator|
        create_list(:comment, evaluator.comments_count, room: room)
      end
    end

  end

end
