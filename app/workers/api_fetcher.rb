class ApiFetcher
  include Sidekiq::Worker
  def perform(query)
    @twitter ||= Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV["twitter_consumer_key"]
     config.consumer_secret     = ENV["twitter_consumer_secret"]
     config.access_token        = ENV["twitter_access_token"]
     config.access_token_secret = ENV["twitter_access_token_secret"]
    end

    @twitter_results = Rails.cache.fetch(@hashtags, :expires_in => 1.hours) do
      @twitter.search("#{query} -rt", result_type: "recent").take(50)
    end

    @twitter_results.each do |tr|
      # puts tr.to_json
      t = Tweet.find_or_initialize_by(tweet_id: tr.id)
      t.data = tr.to_json

      tr.hashtags.each do |hashtag|
        t.tag_list.add(hashtag.text)
      end
      t.save!
    end

  end
end
