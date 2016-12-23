require 'rails_helper'

RSpec.describe "infos/index", type: :view do
  before(:each) do
    assign(:infos, [
      Info.create!(
        :repos => 2,
        :followers => 3,
        :following => 4,
        :owner => nil
      ),
      Info.create!(
        :repos => 2,
        :followers => 3,
        :following => 4,
        :owner => nil
      )
    ])
  end

  it "renders a list of infos" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
