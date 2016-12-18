require 'rails_helper'

RSpec.describe "ownerships/new", type: :view do
  before(:each) do
    assign(:ownership, Ownership.new(
      :user => nil,
      :package => nil
    ))
  end

  it "renders new ownership form" do
    render

    assert_select "form[action=?][method=?]", ownerships_path, "post" do

      assert_select "input#ownership_user_id[name=?]", "ownership[user_id]"

      assert_select "input#ownership_package_id[name=?]", "ownership[package_id]"
    end
  end
end
