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
      @path = "/rooms/#{@room.id}"
    end
    it "ステータス200が返ってくる" do
      get @path, format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "jsonでデータが返ってくる" do
      get @path, format: :json
      json = JSON.parse(response.body)
      expect(json["room"]["name"]).to eq @room.name
      expect(json["room"]["user_id"]).to eq @room.user_id
      expect(json["room"]["description"]).to eq @room.description
    end
  end

  describe 'GET #index' do
    before do
      @rooms = FactoryGirl.create_list(:room, 10)
    end
    it "ステータス200が返ってくる" do
      get '/rooms', format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "jsonでデータが返ってくる" do
      get '/rooms', format: :json
      json = JSON.parse(response.body)
      # 要素が全て取得できていることを確認する
      expect(json["rooms"].length).to eq @rooms.length
      # 値が入っていることを確認する(残りは同じなので、1つめだけ確認する)
      expect(json["rooms"][0]["name"]).to eq @rooms.first.name
      expect(json["rooms"][0]["user_id"]).to eq @rooms.first.user_id
      expect(json["rooms"][0]["description"]).to eq @rooms.first.description
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
    it "編集されたデータがjsonで返ってくる" do
      put @path, @params, format: :json
      @room.reload
      json = JSON.parse(response.body)
      expect(json["name"]).to eq @room.name
      expect(json["user_id"]).to eq @room.user_id
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
    it "データが削除される" do
      expect{
        delete @path, format: :json
      }.to change(Room, :count).by (-1)
    end
  end
end
