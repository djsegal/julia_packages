require 'rails_helper'

RSpec.describe "downloads/edit", type: :view do
  before(:each) do
    @download = assign(:download, Download.create!(
      :name => "MyString",
      :file => "MyString"
    ))
  end

  it "renders the edit download form" do
    render

    assert_select "form[action=?][method=?]", download_path(@download), "post" do

      assert_select "input#download_name[name=?]", "download[name]"

      assert_select "input#download_file[name=?]", "download[file]"
    end
  end
end
