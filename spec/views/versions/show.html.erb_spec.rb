require 'rails_helper'

RSpec.describe "versions/show", type: :view do
  before(:each) do
    @version = assign(:version, Version.create!(
      :package => nil,
      :major => 2,
      :minor => 3,
      :patch => 4,
      :sha1 => "Sha1",
      :number => "Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Sha1/)
    expect(rendered).to match(/Number/)
  end
end
