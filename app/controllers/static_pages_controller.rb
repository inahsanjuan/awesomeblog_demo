class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @microposts = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
end
