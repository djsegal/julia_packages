require 'rails_helper'

RSpec.describe "trendings/show", type: :view do
  before(:each) do
    @trending = assign(:trending, Trending.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
