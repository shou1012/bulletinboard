class Rooms::CommentsController < ApplicationController
  before_action :set_room
  before_action :set_comment, only: [:update, :destroy]

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


  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.json { render json: @comment, status: :accepted }
      else
        format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity, json: { errors: "Invalid Arguments" } }
      end
    end
  end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end

    def comment_params
      params.require(:comment).permit(:id, :text, :user_id, :room_id)
    end

    def set_comment
      begin
        @comment = Comment.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        respond_to do |format|
          format.json { render status: :not_found, json: { errors: "Data not found" } }
        end
      end
    end
end
