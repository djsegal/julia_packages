require 'rails_helper'

RSpec.describe "versions/new", type: :view do
  before(:each) do
    assign(:version, Version.new(
      :package => nil,
      :major => 1,
      :minor => 1,
      :patch => 1,
      :sha1 => "MyString",
      :number => "MyString"
    ))
  end

  it "renders new version form" do
    render

    assert_select "form[action=?][method=?]", versions_path, "post" do

      assert_select "input#version_package_id[name=?]", "version[package_id]"

      assert_select "input#version_major[name=?]", "version[major]"

      assert_select "input#version_minor[name=?]", "version[minor]"

      assert_select "input#version_patch[name=?]", "version[patch]"

      assert_select "input#version_sha1[name=?]", "version[sha1]"

      assert_select "input#version_number[name=?]", "version[number]"
    end
  end
end
