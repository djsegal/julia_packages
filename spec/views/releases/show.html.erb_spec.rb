require 'rails_helper'

RSpec.describe "releases/show", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :tag_name => "Tag Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tag Name/)
  end
end
