require 'spec_helper'

describe Rooms::CommentsController, type: :request do
  describe 'POST #create' do
    before do
      @room = FactoryGirl.create(:room)
      @params = FactoryGirl.attributes_for(:comment, room: @room)
      @path = "/rooms/#{@room.id}/comments"
    end
    it '201が返ってくる' do
      post @path, comment: @params, format: :json
      expect(response).to be_success
      expect(response.status).to eq 201
    end
    it 'commentレコードが1増える' do
      expect { post @path, comment: @params, format: :json}.to change(Comment, :count).by(1)
    end
  end

  describe 'GET #index' do
    before do
      @room = FactoryGirl.create(:room_with_comments)
    end
    it "200が返ってくる" do
      get "/rooms/#{@room.id}/comments", format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "jsonでデータが返ってくる" do
      get "/rooms/#{@room.id}/comments", format: :json
      json = JSON.parse(response.body)
      expect(json["comments"].length).to eq @room.comments.length
      expect(json["comments"][0]["text"]).to eq @room.comments.first.text
      expect(json["comments"][0]["user_id"]).to eq 1
      expect(json["comments"][0]["room_id"]).to eq @room.id
    end
  end

  describe 'PUT #update' do
    before do
      @room = FactoryGirl.create(:room_with_comments, comments_count: 1)
      @comment = @room.comments.first
      @params = FactoryGirl.attributes_for(:comment, text: "edited")
    end
    it '202が返ってくる' do
      put "/rooms/#{@room.id}/comments/#{@comment.id}", comment: @params, format: :json
      @comment.reload
      expect(response).to be_success
      expect(response.status).to eq 202
    end
    it "jsonで更新したデータが返ってくる" do
      put "/rooms/#{@room.id}/comments/#{@comment.id}", comment: @params, format: :json
      @comment.reload
      json = JSON.parse(response.body)
      expect(json["text"]).to eq "edited"
    end
  end

  describe 'DELETE #destroy' do
    before do
      @room = FactoryGirl.create(:room_with_comments, comments_count: 1)
      @comment = @room.comments.first
    end
    it 'レスポンスが返ってくる' do
      delete "/rooms/#{@room.id}/comments/#{@comment.id}", format: :json
      expect(response).to be_success
    end
    # データを削除すること
    it "commentが削除される" do
      expect{
        delete "/rooms/#{@room.id}/comments/#{@comment.id}", format: :json
      }.to change(Comment, :count).by (-1)
    end
  end
end
