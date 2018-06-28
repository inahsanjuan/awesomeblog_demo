class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @microposts = current_user.feed.paginate(page: params[:page])
      @micropost = current_user.microposts.build
    end
  end

  def help
  end
end
