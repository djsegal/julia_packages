require 'rails_helper'

RSpec.describe "contributions/show", type: :view do
  before(:each) do
    @contribution = assign(:contribution, Contribution.create!(
      :user => nil,
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
