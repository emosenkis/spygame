class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: {goto: 'games'}, callback: params[:callback]
    else
      render json: {error: 'Invalid email/password combination'}, callback: params[:callback]
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
