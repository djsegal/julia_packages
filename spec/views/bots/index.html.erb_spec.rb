require 'rails_helper'

RSpec.describe "bots/index", type: :view do
  before(:each) do
    assign(:bots, [
      Bot.create!(
        :name => "Name",
        :avatar => "Avatar"
      ),
      Bot.create!(
        :name => "Name",
        :avatar => "Avatar"
      )
    ])
  end

  it "renders a list of bots" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
  end
end
