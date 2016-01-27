require 'rails_helper'

RSpec.describe "tweets/show", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :tweet_id => "Tweet",
      :data => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tweet/)
    expect(rendered).to match(//)
  end
end
