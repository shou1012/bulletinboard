class UsersController < ApplicationController
  def index
    @users = User.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @user = User.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
