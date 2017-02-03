require 'rails_helper'

RSpec.describe "blurbs/show", type: :view do
  before(:each) do
    @blurb = assign(:blurb, Blurb.create!(
      :cargo => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
