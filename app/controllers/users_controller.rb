class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
