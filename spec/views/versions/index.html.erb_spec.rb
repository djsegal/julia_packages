require 'rails_helper'

RSpec.describe "versions/index", type: :view do
  before(:each) do
    assign(:versions, [
      Version.create!(
        :package => nil,
        :major => 2,
        :minor => 3,
        :patch => 4,
        :sha1 => "Sha1",
        :number => "Number"
      ),
      Version.create!(
        :package => nil,
        :major => 2,
        :minor => 3,
        :patch => 4,
        :sha1 => "Sha1",
        :number => "Number"
      )
    ])
  end

  it "renders a list of versions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Sha1".to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
  end
end
