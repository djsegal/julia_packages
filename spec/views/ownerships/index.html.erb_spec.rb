require 'rails_helper'

RSpec.describe "ownerships/index", type: :view do
  before(:each) do
    assign(:ownerships, [
      Ownership.create!(
        :user => nil,
        :package => nil
      ),
      Ownership.create!(
        :user => nil,
        :package => nil
      )
    ])
  end

  it "renders a list of ownerships" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
