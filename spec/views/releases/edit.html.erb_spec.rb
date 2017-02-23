require 'rails_helper'

RSpec.describe "releases/edit", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :tag_name => "MyString"
    ))
  end

  it "renders the edit release form" do
    render

    assert_select "form[action=?][method=?]", release_path(@release), "post" do

      assert_select "input#release_tag_name[name=?]", "release[tag_name]"
    end
  end
end
