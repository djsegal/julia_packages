require 'rails_helper'

RSpec.describe "searches/show", type: :view do
  before(:each) do
    @search = assign(:search, Search.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
