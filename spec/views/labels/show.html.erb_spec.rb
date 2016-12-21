require 'rails_helper'

RSpec.describe "labels/show", type: :view do
  before(:each) do
    @label = assign(:label, Label.create!(
      :category => nil,
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
