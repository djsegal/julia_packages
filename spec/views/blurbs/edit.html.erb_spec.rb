require 'rails_helper'

RSpec.describe "blurbs/edit", type: :view do
  before(:each) do
    @blurb = assign(:blurb, Blurb.create!(
      :cargo => "MyText"
    ))
  end

  it "renders the edit blurb form" do
    render

    assert_select "form[action=?][method=?]", blurb_path(@blurb), "post" do

      assert_select "textarea#blurb_cargo[name=?]", "blurb[cargo]"
    end
  end
end
