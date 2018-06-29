class VotesController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    # current_user.votes.create(micropost: micropost)
    current_user.upvote(micropost)

    redirect_to request.referrer || root_url
  end

  def destroy
    micropost = Vote.find(params[:id]).micropost
    current_user.downvote(micropost)

	# vote = Vote.find(params[:id]) 
    # vote.destroy

    redirect_to request.referrer || root_url
  end
end
