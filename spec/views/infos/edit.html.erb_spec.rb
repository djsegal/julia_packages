require 'rails_helper'

RSpec.describe "infos/edit", type: :view do
  before(:each) do
    @info = assign(:info, Info.create!(
      :repos => 1,
      :followers => 1,
      :following => 1,
      :owner => nil
    ))
  end

  it "renders the edit info form" do
    render

    assert_select "form[action=?][method=?]", info_path(@info), "post" do

      assert_select "input#info_repos[name=?]", "info[repos]"

      assert_select "input#info_followers[name=?]", "info[followers]"

      assert_select "input#info_following[name=?]", "info[following]"

      assert_select "input#info_owner_id[name=?]", "info[owner_id]"
    end
  end
end
