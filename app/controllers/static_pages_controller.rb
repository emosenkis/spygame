class StaticPagesController < ApplicationController
  before_filter :force_mobile_format, only: :home
  def home
    redirect_to signin_path
  end

  def help
  end

  def about
  end

  def contact
  end
end
