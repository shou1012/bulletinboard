require 'spec_helper'

describe Room do
  it "has a valid factory" do
    expect(build(:room)).to be_valid
  end
  it "is not valid without a name" do
    expect(FactoryGirl.build(:room, name: nil)).to_not be_valid
  end
  it "is not valid without a user_id" do
    expect(FactoryGirl.build(:room, user_id: nil)).to_not be_valid
  end
  it "returns a room's name as a string" do
    room = FactoryGirl.build(:room, name: "room2", user_id: 2)
    expect(room.name).to eq "room2"
  end
end
