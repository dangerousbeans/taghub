require 'rails_helper'

RSpec.describe "tweets/edit", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :tweet_id => "MyString",
      :data => ""
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do

      assert_select "input#tweet_tweet_id[name=?]", "tweet[tweet_id]"

      assert_select "input#tweet_data[name=?]", "tweet[data]"
    end
  end
end
