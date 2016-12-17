require 'rails_helper'

RSpec.describe "dummies/edit", type: :view do
  before(:each) do
    @dummy = assign(:dummy, Dummy.create!())
  end

  it "renders the edit dummy form" do
    render

    assert_select "form[action=?][method=?]", dummy_path(@dummy), "post" do
    end
  end
end
