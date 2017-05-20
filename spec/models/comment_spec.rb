require 'spec_helper'

describe Comment do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end
  # 名前とuser_idがあれば有効な状態であること
  it "is valid with a text, room_id,  and user_id" do
    comment = Comment.new(
      text: 'about room1',
      room_id: 1,
      user_id: 1
    )
  expect(comment).to be_valid
  end
  # 名前がなければ無効な状態であること
  it "is not valid without a text" do
    expect(FactoryGirl.build(:comment, text: nil)).to_not be_valid
  end

  # user_idがなければ無効な状態であること
  it "is not valid without a user_id" do
    expect(FactoryGirl.build(:comment, user_id: nil)).to_not be_valid
  end

  # 名前と詳細を文字列として返すこと
  it "returns a comment's text as a string" do
    comment = FactoryGirl.build(:comment, text: "text about room2", room_id: 2)
    expect(comment.text).to eq "text about room2"
  end

end
