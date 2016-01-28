class SearchController < ApplicationController

  RESULT_SET = 300

  def index

    @hashtags = params[:tags]
    @hashtags = "" if @hashtags.nil?

    @twitter ||= Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV["twitter_consumer_key"]
     config.consumer_secret     = ENV["twitter_consumer_secret"]
     config.access_token        = ENV["twitter_access_token"]
     config.access_token_secret = ENV["twitter_access_token_secret"]
    end

    [ "#makerhood" ].each do |forced_keyword|
      @hashtags = "#{@hashtags} #{forced_keyword}" unless @hashtags.include?(forced_keyword)
    end

    # Pick out the main tags
    focus_tags = @hashtags.split(" ")

    @active_tags = []
    focus_tags.each do |t|
      t = t.gsub("#", "")
      t = Tag.where('lower(name) = ?', t.downcase).first

      @active_tags.push t if t
    end

    @twitter_results = @twitter.search("#{@hashtags} -rt", result_type: "recent").take(50)

    @twitter_results.each do |tr|
      t = Tweet.find_or_initialize_by(tweet_id: tr.id)
      t.data = tr.to_json

      tr.hashtags.each do |hashtag|
        t.tag_list.add(hashtag.text)
      end
      t.save!
    end
    #
    # @video_results = Rails.cache.fetch(@hashtags, expires_in: 2.hours) do
    #   videos = Yt::Collections::Videos.new
    #   @video_results = videos.where(q: @hashtags)
    # end

    @twitter_results = Elasticsearch::Model.search({ query: { "query_string": { query: @hashtags.split(" ").join(" AND ") } } }, [Tweet, Story]).records.to_a

    @social_results = @twitter_results# + @video_results
    #
    # @video_results.each.with_index do |video, i|
    #   @social_results << video
    #
    #   break if i > 10
    # end

    # @social_results.shuffle!

    @tags = Tag.where("name != 'makerhood' AND taggings_count > 0").order(taggings_count: :desc).limit(30)
  end
end
