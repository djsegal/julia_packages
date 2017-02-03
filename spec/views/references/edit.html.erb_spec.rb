require 'rails_helper'

RSpec.describe "references/edit", type: :view do
  before(:each) do
    @reference = assign(:reference, Reference.create!(
      :link => "MyString"
    ))
  end

  it "renders the edit reference form" do
    render

    assert_select "form[action=?][method=?]", reference_path(@reference), "post" do

      assert_select "input#reference_link[name=?]", "reference[link]"
    end
  end
end
