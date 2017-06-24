require 'rails_helper'

RSpec.describe "visits/edit", type: :view do
  before(:each) do
    @visit = assign(:visit, Visit.create!())
  end

  it "renders the edit visit form" do
    render

    assert_select "form[action=?][method=?]", visit_path(@visit), "post" do
    end
  end
end
