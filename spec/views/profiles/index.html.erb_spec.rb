require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        :nickname => "Nickname",
        :company => "Company",
        :blog => "Blog",
        :location => "Location",
        :bio => "Bio",
        :owner => nil
      ),
      Profile.create!(
        :nickname => "Nickname",
        :company => "Company",
        :blog => "Blog",
        :location => "Location",
        :bio => "Bio",
        :owner => nil
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Blog".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Bio".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
