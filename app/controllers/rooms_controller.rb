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
    else
        format.json { render json: @room.errors, status: :unprocessable_entity }
    end
  end

  private
    def room_params
      params.require(:room).permit(:name, :user_id, :description)
    end
end
