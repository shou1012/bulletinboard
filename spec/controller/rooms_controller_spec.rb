require 'spec_helper'
describe RoomsController, :type => :request do
  describe 'POST #create' do
    before do
      @params = FactoryGirl.attributes_for(:room)
    end
    it '201が返ってくる' do
      post rooms_path, room: @params, format: :json
      expect(response).to be_success
      expect(response.status).to eq 201
    end
    it 'Roomレコードが1増える' do
      expect { post rooms_path, room: @params, format: :json}.to change(Room, :count).by(1)
    end
  end

  # describe 'GET #new' do
  #   # @room に新しい連絡先を割りあてること
  #   it "assigns a new Room to @room" do
  #     get :new
  #     expect(assigns(:room)).to be_a_new(Room)
  #   end
  #   # :new　テンプレートを表示すること
  #   it "renders the :new template" do
  #     expect(response).to render_template :new
  #   end
  # end
  #
  # describe 'GET #edit' do
  #   # @room に新しい連絡先を割りあてること
  #   it "assigns the requested room to @room" do
  #     room = create(:room)
  #     get :edit, id: room
  #     expect(assigns(:room)).to eq room
  #   end
  #   # :index　テンプレートを表示すること
  #   it "renders the :edit template" do
  #     room = create(:room)
  #     get :edit, id: room
  #     expect(response).to render_template :edit
  #   end
  # end

  describe 'GET #show' do
    before do
      @room = FactoryGirl.create(:room)
      get :show, id: @room.id, format: :json
    end

    it "201が返ってくる" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    # it "responses with json data" do
    #   json = JSON.parse(response.body)
    #   expect(json['name']).to eq "room1"
    #   expect(json['user_id']).to eq 1
    #   expect(json['description']).to "about room1"
    # end
  end

  # describe 'PATCH #update' do
    # before :each do
    #   @room = create(:room,
    #   name: "room1",
    #   user_id: 1,
    #   description: "about room1"
    #   )
    # end
    # #要求された@roomを取得すること
    # it "locates the requersted @room" do
    #   patch :update, id: @room, room: attributes_for(:room)
    #   expect(assigns(:room)).to eq (@room)
    # end
    # #@roomの属性を変更すること
    # it "changes @room's attributes" do
    #   patch :update, id: @room, room: attributes_for(:room,
    #     name: 'room2', user_id: 2, description: "about room2")
    #   @room.reload
    #   expect(@room.name).to eq("room2")
    #   expect(@room.description).to eq("about room2")
    # end
    #
    # it "redirects to rooms_path" do
    #   patch :update, id: @room, room: attributes_for(:room)
    #   expect(response).to redirect_to rooms_path
    # end
  # end

  # describe 'DELETE #destroy' do
  #   before :each do
  #     @room = create(:room)
  #   end
  #   # データを削除すること
  #   it "deletes the room" do
  #     expect{
  #       delete :destroy, id: @room
  #     }.to change(Room, :count).by (-1)
  #   end
  #   # rooms_indexにリダイレクトすること
  #   it "redirects to rooms_index" do
  #     delete :destroy, id: @room
  #     expect(response).to redirect_to rooms_url
  #   end
  # end
end
