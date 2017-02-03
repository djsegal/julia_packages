require 'rails_helper'

RSpec.describe "blurbs/new", type: :view do
  before(:each) do
    assign(:blurb, Blurb.new(
      :cargo => "MyText"
    ))
  end

  it "renders new blurb form" do
    render

    assert_select "form[action=?][method=?]", blurbs_path, "post" do

      assert_select "textarea#blurb_cargo[name=?]", "blurb[cargo]"
    end
  end
end
