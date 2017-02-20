require 'rails_helper'

RSpec.describe "downloads/index", type: :view do
  before(:each) do
    assign(:downloads, [
      Download.create!(
        :name => "Name",
        :file => "File"
      ),
      Download.create!(
        :name => "Name",
        :file => "File"
      )
    ])
  end

  it "renders a list of downloads" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
  end
end
