require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end
  it "is valid with a text, room_id,  and user_id" do
    comment = Comment.new(
      text: 'about room1',
      room_id: 1,
      user_id: 1
    )
  expect(comment).to be_valid
  end
  it "is not valid without a text" do
    expect(FactoryGirl.build(:comment, text: nil)).to_not be_valid
  end
  it "is not valid without a user_id" do
    expect(FactoryGirl.build(:comment, user_id: nil)).to_not be_valid
  end
  it "returns a comment's text as a string" do
    comment = FactoryGirl.build(:comment, text: "text about room2", room_id: 2)
    expect(comment.text).to eq "text about room2"
  end

end
