require 'rails_helper'

RSpec.describe "tweets/index", type: :view do
  before(:each) do
    assign(:tweets, [
      Tweet.create!(
        :tweet_id => "Tweet",
        :data => ""
      ),
      Tweet.create!(
        :tweet_id => "Tweet",
        :data => ""
      )
    ])
  end

  it "renders a list of tweets" do
    render
    assert_select "tr>td", :text => "Tweet".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
