class StaticPagesController < ApplicationController
  before_filter :force_mobile_format, only: :home
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
