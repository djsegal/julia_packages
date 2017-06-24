require 'rails_helper'

RSpec.describe "visits/index", type: :view do
  before(:each) do
    assign(:visits, [
      Visit.create!(),
      Visit.create!()
    ])
  end

  it "renders a list of visits" do
    render
  end
end
