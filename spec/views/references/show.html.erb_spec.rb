require 'rails_helper'

RSpec.describe "references/show", type: :view do
  before(:each) do
    @reference = assign(:reference, Reference.create!(
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Link/)
  end
end
