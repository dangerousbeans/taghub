class VoteController < ApplicationController

  def vote_up

    video = Video.find(params[:id])
    video.vote!(request.ip)

    # current_user.vote_exclusively_for(@leaf) unless current_user.voted_for?(@leaf)
    # @leaf.save!
    # @leaf.log_vote_for(current_user)
  end

  def vote_down
    current_user.vote_exclusively_against(@leaf) unless current_user.voted_against?(@leaf)
    @leaf.save!
    @leaf.log_vote_against(current_user)
  end

  private

    def get_leaf
      @leaf = Leaf.find(params[:id])
    end
end
