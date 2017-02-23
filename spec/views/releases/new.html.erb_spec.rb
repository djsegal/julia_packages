require 'rails_helper'

RSpec.describe "releases/new", type: :view do
  before(:each) do
    assign(:release, Release.new(
      :tag_name => "MyString"
    ))
  end

  it "renders new release form" do
    render

    assert_select "form[action=?][method=?]", releases_path, "post" do

      assert_select "input#release_tag_name[name=?]", "release[tag_name]"
    end
  end
end
