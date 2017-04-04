class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    respond_to do |format|
    format.json { render json: @rooms } # URLが.jsonの場合、@products.to_json が返される
    end
  end

  def show
    @room = Room.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
   end
  end
