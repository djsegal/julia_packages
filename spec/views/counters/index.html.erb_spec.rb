require 'rails_helper'

RSpec.describe "counters/index", type: :view do
  before(:each) do
    assign(:counters, [
      Counter.create!(
        :fork => 2,
        :stargazer => 3,
        :open_issue => 6,
        :package => nil
      ),
      Counter.create!(
        :fork => 2,
        :stargazer => 3,
        :open_issue => 6,
        :package => nil
      )
    ])
  end

  it "renders a list of counters" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
