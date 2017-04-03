class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    respond_to do |format|
    format.html # => 通常のURLの場合、index.html.erb が返される
    format.json { render json: @rooms } # URLが.jsonの場合、@products.to_json が返される
    end
  end
end
