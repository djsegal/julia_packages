require 'rails_helper'

RSpec.describe "daters/show", type: :view do
  before(:each) do
    @dater = assign(:dater, Dater.create!(
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
