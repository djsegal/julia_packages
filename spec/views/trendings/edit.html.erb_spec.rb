require 'rails_helper'

RSpec.describe "trendings/edit", type: :view do
  before(:each) do
    @trending = assign(:trending, Trending.create!())
  end

  it "renders the edit trending form" do
    render

    assert_select "form[action=?][method=?]", trending_path(@trending), "post" do
    end
  end
end
