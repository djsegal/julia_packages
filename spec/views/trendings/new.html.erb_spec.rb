require 'rails_helper'

RSpec.describe "trendings/new", type: :view do
  before(:each) do
    assign(:trending, Trending.new())
  end

  it "renders new trending form" do
    render

    assert_select "form[action=?][method=?]", trendings_path, "post" do
    end
  end
end
