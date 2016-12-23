require 'rails_helper'

RSpec.describe "profiles/new", type: :view do
  before(:each) do
    assign(:profile, Profile.new(
      :nickname => "MyString",
      :company => "MyString",
      :blog => "MyString",
      :location => "MyString",
      :bio => "MyString",
      :owner => nil
    ))
  end

  it "renders new profile form" do
    render

    assert_select "form[action=?][method=?]", profiles_path, "post" do

      assert_select "input#profile_nickname[name=?]", "profile[nickname]"

      assert_select "input#profile_company[name=?]", "profile[company]"

      assert_select "input#profile_blog[name=?]", "profile[blog]"

      assert_select "input#profile_location[name=?]", "profile[location]"

      assert_select "input#profile_bio[name=?]", "profile[bio]"

      assert_select "input#profile_owner_id[name=?]", "profile[owner_id]"
    end
  end
end
