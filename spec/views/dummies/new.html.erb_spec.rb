require 'rails_helper'

RSpec.describe "dummies/new", type: :view do
  before(:each) do
    assign(:dummy, Dummy.new())
  end

  it "renders new dummy form" do
    render

    assert_select "form[action=?][method=?]", dummies_path, "post" do
    end
  end
end
