class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @room = Room.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
   end
end
