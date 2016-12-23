require 'rails_helper'

RSpec.describe "infos/show", type: :view do
  before(:each) do
    @info = assign(:info, Info.create!(
      :repos => 2,
      :followers => 3,
      :following => 4,
      :owner => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
  end
end
