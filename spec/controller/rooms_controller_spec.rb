require 'spec_helper'

describe RoomsController, :type => :request do
  describe 'POST #create' do
    before do
      @params = FactoryGirl.attributes_for(:room)
    end
    it 'ステータス201が返ってくる' do
      post rooms_path, room: @params, format: :json
      expect(response).to be_success
      expect(response.status).to eq 201
    end
    it 'Roomsレコードが1増える' do
      post rooms_path, room: @params, format: :json
      expect { post rooms_path, room: @params, format: :json}.to change(Room, :count).by(1)
    end
  end

  describe 'GET #show' do
    before do
      @room = FactoryGirl.create(:room)
    end
    it "ステータス200が返ってくる" do
      get '/rooms/:id', id: @room.id, format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "jsonでデータが返ってくる" do
      get '/rooms/:id', id: @room.id, format: :json
      json = JSON.parse(response.body)
      expect(json["room"]["name"]).to eq "room1"
      expect(json["room"]["user_id"]).to eq 1
      expect(json["room"]["description"]).to eq "about room1"
    end
  end

  describe 'PUT #update' do
    before do
      @room = FactoryGirl.create(:room)
      @params = { room: FactoryGirl.attributes_for(:room, description:  'edited')}
      @path = "/rooms/#{@room.id}.json"
    end
    it 'ステータス202が返ってくる' do
      put @path, @params, format: :json
      @room.reload

      expect(response).to be_success
      expect(response.status).to eq 202
    end
    #@roomの属性を変更すること
    it "編集されたデータがjsonで返ってくる" do
      put @path, @params, format: :json
      @room.reload
      json = JSON.parse(response.body)
      expect(json["name"]).to eq "room1"
      expect(json["user_id"]).to eq 1
      expect(json["description"]).to eq "edited"
    end
  end

  describe 'DELETE #destroy' do
    before do
      @room = FactoryGirl.create(:room)
      @path = "/rooms/#{@room.id}.json"
    end
    it 'レスポンスが返ってくる' do
      delete @path, format: :json
      expect(response).to be_success
    end
    # データを削除すること
    it "データが削除される" do
      expect{
        delete @path, format: :json
      }.to change(Room, :count).by (-1)
    end
  end
end
