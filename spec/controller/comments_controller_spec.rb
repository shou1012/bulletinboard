require 'spec_helper'

describe Rooms::CommentsController, type: :request do
  describe 'POST #create' do
    let(:room) { FactoryGirl.create(:room) }
    let(:params) { FactoryGirl.attributes_for(:comment, room: room) }
    let(:path) { "/rooms/#{room.id}/comments" }
    it 'returns status 201' do
      post path, comment: params, format: :json
      expect(response).to be_success
      expect(response.status).to eq 201
    end
    it 'increases comment count by 1' do
      expect { post path, comment: params, format: :json}.to change(Comment, :count).by(1)
    end
  end

  describe 'GET #index' do
    let(:room) { FactoryGirl.create(:room_with_comments) }
    it "returns status 200" do
      get "/rooms/#{room.id}/comments", format: :json
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it "returns data by json" do
      get "/rooms/#{room.id}/comments", format: :json
      json = JSON.parse(response.body)
      expect(json["comments"].length).to eq room.comments.length
      expect(json["comments"][0]["text"]).to eq room.comments.first.text
      expect(json["comments"][0]["user_id"]).to eq 1
      expect(json["comments"][0]["room_id"]).to eq room.id
    end
  end

  describe 'PUT #update' do
    let(:room) { FactoryGirl.create(:room_with_comments, comments_count: 1) }
    let(:comment) { room.comments.first }
    let(:params) { FactoryGirl.attributes_for(:comment, text: "edited") }
    it 'returns status 202' do
      put "/rooms/#{room.id}/comments/#{comment.id}", comment: params, format: :json
      comment.reload
      expect(response).to be_success
      expect(response.status).to eq 202
    end
    it "returns updated data by json" do
      put "/rooms/#{room.id}/comments/#{comment.id}", comment: params, format: :json
      comment.reload
      json = JSON.parse(response.body)
      expect(json["text"]).to eq "edited"
    end
  end

  describe 'DELETE #destroy' do
    let(:room) { FactoryGirl.create(:room_with_comments, comments_count: 1)}
    let(:comment) { room.comments.first}
    it 'returns success' do
      delete "/rooms/#{room.id}/comments/#{comment.id}", format: :json
      expect(response).to be_success
    end
    it "deletes comment" do
      expect{
        delete "/rooms/#{room.id}/comments/#{comment.id}", format: :json
      }.to change(count).by (-1)
    end
  end
end
