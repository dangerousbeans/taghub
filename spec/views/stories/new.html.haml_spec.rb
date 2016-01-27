require 'rails_helper'

RSpec.describe "stories/new", type: :view do
  before(:each) do
    assign(:story, Story.new(
      :name => "MyString",
      :latlong => "",
      :data => ""
    ))
  end

  it "renders new story form" do
    render

    assert_select "form[action=?][method=?]", stories_path, "post" do

      assert_select "input#story_name[name=?]", "story[name]"

      assert_select "input#story_latlong[name=?]", "story[latlong]"

      assert_select "input#story_data[name=?]", "story[data]"
    end
  end
end
