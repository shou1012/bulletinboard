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
    respond_to do |format|
      if @room.save
        format.json { render json: @room, status: :created }
      else
        format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }}
      end
    end
  end

  private
    def room_params
      params.require(:room).permit(:name, :user_id, :description)
    end
end
