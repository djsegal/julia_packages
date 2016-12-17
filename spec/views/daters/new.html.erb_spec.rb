require 'rails_helper'

RSpec.describe "daters/new", type: :view do
  before(:each) do
    assign(:dater, Dater.new(
      :package => nil
    ))
  end

  it "renders new dater form" do
    render

    assert_select "form[action=?][method=?]", daters_path, "post" do

      assert_select "input#dater_package_id[name=?]", "dater[package_id]"
    end
  end
end
