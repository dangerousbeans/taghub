class VoteController < ApplicationController

  def vote_up
    tweet = Tweet.find(params[:id])
    tweet.vote!(request.ip)

    @tweet = tweet
  end
end
