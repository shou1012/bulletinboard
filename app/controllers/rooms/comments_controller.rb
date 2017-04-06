class Rooms::CommentsController < ApplicationController
  before_action :set_room

  def index
    @comments = @room.comments
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end
end
