class RoomsController < ApplicationController
  before_action :set_room, only: [:update, :destroy]

  def index
    @rooms = Room.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    set_room
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

  def update
      respond_to do |format|
        if @room.update(room_params)
          format.json { render json: @room, status: :updated }
        else
          format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }}
        end
      end
  end

  def destroy
    if @room
      respond_to do |format|
        if @room.destroy
          format.json { head :no_content }
        else
          format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" } }
        end
      end
    end
  end

  private
    def room_params
      params.require(:room).permit(:name, :user_id, :description)
    end

    def set_room
      begin
        @room = Room.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        respond_to do |format|
          format.json { render status: :not_found, json: { errors: "Data not found" } }
        end
      end
    end

end
