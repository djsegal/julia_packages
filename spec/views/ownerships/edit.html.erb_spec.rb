require 'rails_helper'

RSpec.describe "ownerships/edit", type: :view do
  before(:each) do
    @ownership = assign(:ownership, Ownership.create!(
      :user => nil,
      :package => nil
    ))
  end

  it "renders the edit ownership form" do
    render

    assert_select "form[action=?][method=?]", ownership_path(@ownership), "post" do

      assert_select "input#ownership_user_id[name=?]", "ownership[user_id]"

      assert_select "input#ownership_package_id[name=?]", "ownership[package_id]"
    end
  end
end
