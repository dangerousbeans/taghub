require 'rails_helper'

RSpec.describe "tweets/new", type: :view do
  before(:each) do
    assign(:tweet, Tweet.new(
      :tweet_id => "MyString",
      :data => ""
    ))
  end

  it "renders new tweet form" do
    render

    assert_select "form[action=?][method=?]", tweets_path, "post" do

      assert_select "input#tweet_tweet_id[name=?]", "tweet[tweet_id]"

      assert_select "input#tweet_data[name=?]", "tweet[data]"
    end
  end
end
