require 'rails_helper'

RSpec.describe "daters/edit", type: :view do
  before(:each) do
    @dater = assign(:dater, Dater.create!(
      :package => nil
    ))
  end

  it "renders the edit dater form" do
    render

    assert_select "form[action=?][method=?]", dater_path(@dater), "post" do

      assert_select "input#dater_package_id[name=?]", "dater[package_id]"
    end
  end
end
