class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
