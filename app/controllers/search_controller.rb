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

    @twitter_results = @twitter.search("#{@hashtags} -rt", result_type: "recent").take(20)

    @video_results = Rails.cache.fetch(@hashtags, expires_in: 2.hours) do
      videos = Yt::Collections::Videos.new
      @video_results = videos.where(q: @hashtags)
    end

    @social_results = @twitter_results

    @video_results.each.with_index do |video, i|
      @social_results << video

      break if i > 10
    end

    @social_results.shuffle!

    if params[:q].blank?
      @results = Elasticsearch::Model.search( { query: { match_all: {} } }, [Place, Person]).page(params[:page]).records
      @all_results = Elasticsearch::Model.search( { query: { match_all: {} }, size: RESULT_SET }, [Place, Person]).records.to_a
    else
      @results = Elasticsearch::Model.search(params[:q], [Place, Person]).page(params[:page]).records
      @all_results = Elasticsearch::Model.search(params[:q], [Place, Person]).records.to_a
    end
    @tags = Tag.all
  end
end
