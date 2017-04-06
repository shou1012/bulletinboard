class Rooms::CommentsController < ApplicationController
  before_action :set_room

  def index
    @comments = @room.comments
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment, status: :created }
      else
        format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }}
      end
    end
  end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :user_id, :room_id)
    end
end
