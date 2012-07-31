class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: {goto: 'games'}, callback: params[:callback]
    else
      render json: {alert: 'Invalid email/password combination'}, callback: params[:callback]
    end
  end

  def destroy
    sign_out
    render json: {goto: 'signin'}, callback: params[:callback]
  end

  def check
    if signed_in?
      render json: {goto: 'games'}, callback: params[:callback]
    else
      render json: {}, callback: params[:callback]
    end
  end
end
