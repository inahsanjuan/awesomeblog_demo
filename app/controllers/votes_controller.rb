class VotesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.votes.create(micropost: micropost)

    redirect_to root_url
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy

    redirect_to root_url
  end
end
