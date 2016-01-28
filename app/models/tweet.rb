class Tweet < ActiveRecord::Base
  acts_as_taggable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :votes

  def vote!(ip)
    unless Vote.recent.exists?(:ip => ip, :tweet_id => id)
      increment!(:votes_up)
      Vote.create(:ip => ip, :tweet_id => id)
    end
  end

  def safe_data
    OpenStruct.new(data)
  end

  def youtube
    safe_data.to_s.include?("youtu")
  end

  # Called by the elasticsearch indexer and should add the tag names
  def as_indexed_json(options={})
    as_json(include: { tags: { only: :name } } )
  end
end
