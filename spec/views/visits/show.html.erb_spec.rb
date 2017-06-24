require 'rails_helper'

RSpec.describe "visits/show", type: :view do
  before(:each) do
    @visit = assign(:visit, Visit.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
