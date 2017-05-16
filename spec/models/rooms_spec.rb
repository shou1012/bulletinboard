require 'spec_helper'

describe Room do
  #有効なファクトリを持つこと
  it "has a valid factory" do
    expect(build(:room)).to be_valid
  end
  # # 名前がなければ無効な状態であること
  it "is not valid without a name" do
    room = FactoryGirl.build(:room, name: nil)
    expect(room).to have(1).errors_on(:name)
  end
  # user_idがなければ無効な状態であること
  it "is not valid without a user_id" do
    room = FactoryGirl.build(:room, user_id: nil)
    expect(room).to have(1).errors_on(:user_id)
  end
  # 名前と詳細を文字列として返すこと
  it "returns a room's name as a string" do
    room = FactoryGirl.build(:room, name: "room2", user_id: 2)
    expect(room.name).to eq "room2"
  end
end
