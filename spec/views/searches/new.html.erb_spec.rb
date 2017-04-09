require 'rails_helper'

RSpec.describe "searches/new", type: :view do
  before(:each) do
    assign(:search, Search.new())
  end

  it "renders new search form" do
    render

    assert_select "form[action=?][method=?]", searches_path, "post" do
    end
  end
end
