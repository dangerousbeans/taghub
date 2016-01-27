json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :tweet_id, :data
  json.url tweet_url(tweet, format: :json)
end
