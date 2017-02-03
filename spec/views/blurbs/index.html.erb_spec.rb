require 'rails_helper'

RSpec.describe "blurbs/index", type: :view do
  before(:each) do
    assign(:blurbs, [
      Blurb.create!(
        :cargo => "MyText"
      ),
      Blurb.create!(
        :cargo => "MyText"
      )
    ])
  end

  it "renders a list of blurbs" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
