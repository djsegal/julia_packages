require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :nickname => "Nickname",
      :company => "Company",
      :blog => "Blog",
      :location => "Location",
      :bio => "Bio",
      :owner => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/Blog/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Bio/)
    expect(rendered).to match(//)
  end
end
