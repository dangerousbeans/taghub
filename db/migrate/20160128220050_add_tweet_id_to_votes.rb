class AddTweetIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :tweet_id, :integer
    add_column :tweets, :votes_up, :integer, default: 0
  end
end
