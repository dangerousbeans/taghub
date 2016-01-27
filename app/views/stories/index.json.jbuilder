json.array!(@stories) do |story|
  json.extract! story, :id, :name, :latlong, :data
  json.url story_url(story, format: :json)
end
