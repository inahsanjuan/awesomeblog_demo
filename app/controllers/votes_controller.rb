class VotesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.votes.create(micropost: @micropost)

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
    # redirect_to root_url
  end

  def destroy
    @micropost = Vote.find(params[:id]).micropost
    @micropost.voters.delete(current_user)

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
