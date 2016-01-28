class SearchController < ApplicationController

  RESULT_SET = 300

  def index

    @hashtags = params[:tags]
    @hashtags = "" if @hashtags.nil?

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

    ApiFetcher.perform_async(@hashtags)

    @twitter_results = Elasticsearch::Model.search({ query: { "query_string": { query: @hashtags.split(" ").join(" AND ") } } }, [Tweet, Story]).records.to_a

    @social_results = @twitter_results# + @video_results


    @tags = Tag.where("name != 'makerhood' AND taggings_count > 0").order(taggings_count: :desc).limit(30)
  end
end
