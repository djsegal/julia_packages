require 'rails_helper'

RSpec.describe "repositories/index", type: :view do
  before(:each) do
    assign(:repositories, [
      Repository.create!(
        :package => nil,
        :url => "Url"
      ),
      Repository.create!(
        :package => nil,
        :url => "Url"
      )
    ])
  end

  it "renders a list of repositories" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
