require 'rails_helper'

RSpec.describe "contributions/new", type: :view do
  before(:each) do
    assign(:contribution, Contribution.new(
      :user => nil,
      :package => nil
    ))
  end

  it "renders new contribution form" do
    render

    assert_select "form[action=?][method=?]", contributions_path, "post" do

      assert_select "input#contribution_user_id[name=?]", "contribution[user_id]"

      assert_select "input#contribution_package_id[name=?]", "contribution[package_id]"
    end
  end
end
