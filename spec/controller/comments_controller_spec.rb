require 'spec_helper'

describe Rooms::CommentsController, :type => :request do
  describe 'POST #create' do
    before do
      @room = FactoryGirl.create(:room)
      @params = FactoryGirl.attributes_for(:comment)
    end
    it '201が返ってくる' do
      post "/rooms/:room_id/comments", comment: @params , format: :json
      expect(response).to be_success
      expect(response.status).to eq 201
    end
    it 'commentレコードが1増える' do
      expect { post "/rooms/:room_id/comments", comment: @params, format: :json}.to change(Comment, :count).by(1)
    end
  end

  describe 'GET #index' do
    before do
      @params = FactoryGirl.create(:comment)
    end
    it "200が返ってくる" do
      get "/rooms/:id/comments", comment: @params, format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "responses with json data" do
      get "/rooms/:id/comments", comment: @params, format: :json
      json = JSON.parse(response.body)
      expect(json["comments"["text"]]).to eq "comment about room1"
      expect(json["user_id"]).to eq 1
      expect(json["room_id"]).to eq 0
    end
  end

  describe 'PUT #update' do
    before do
      @comment = FactoryGirl.create(:comment)
      @params = FactoryGirl.attributes_for(:comment, text: "edited")
    end
    it '202が返ってくる' do
      put "/rooms/:room_id/comments/:id", comment: @params, format: :json
      @comment.reload
      expect(response).to be_success
      expect(response.status).to eq 202
    end
    #@commentの属性を変更すること
    it "changes @comment's attributes" do
      put "/rooms/:room_id/comments/:id", comment: @params, format: :json
      @comment.reload
      json = JSON.parse(response.body)
      expect(json["text"]).to eq "edited"
    end
  end

  describe 'DELETE #destroy' do
    before do
      @comment = FactoryGirl.create(:comment)
    end
    it 'レスポンスが返ってくる' do
      delete "/rooms/:room_id/comments/:id", format: :json
      expect(response).to be_success
    end
    # データを削除すること
    it "deletes the comment" do
      expect{
        delete "/rooms/:room_id/comments/:id", format: :json
      }.to change(Comment, :count).by (-1)
    end
  end
end
