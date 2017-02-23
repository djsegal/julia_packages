require 'rails_helper'

RSpec.describe "releases/index", type: :view do
  before(:each) do
    assign(:releases, [
      Release.create!(
        :tag_name => "Tag Name"
      ),
      Release.create!(
        :tag_name => "Tag Name"
      )
    ])
  end

  it "renders a list of releases" do
    render
    assert_select "tr>td", :text => "Tag Name".to_s, :count => 2
  end
end
