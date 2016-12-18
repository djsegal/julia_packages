require 'rails_helper'

RSpec.describe "contributions/index", type: :view do
  before(:each) do
    assign(:contributions, [
      Contribution.create!(
        :user => nil,
        :package => nil
      ),
      Contribution.create!(
        :user => nil,
        :package => nil
      )
    ])
  end

  it "renders a list of contributions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
