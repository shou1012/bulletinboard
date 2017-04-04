class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @room = Room.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
   end

  def create
    @room = Room.new(room_params)
    if @room.save
      respond_to do |format|
        format.json { render json: @room, status: :created }
      end
    end
  end

  private
    def room_params
      params.permit(:name, :user_id, :description)
    end
end
