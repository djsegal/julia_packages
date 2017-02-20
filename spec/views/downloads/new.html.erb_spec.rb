require 'rails_helper'

RSpec.describe "downloads/new", type: :view do
  before(:each) do
    assign(:download, Download.new(
      :name => "MyString",
      :file => "MyString"
    ))
  end

  it "renders new download form" do
    render

    assert_select "form[action=?][method=?]", downloads_path, "post" do

      assert_select "input#download_name[name=?]", "download[name]"

      assert_select "input#download_file[name=?]", "download[file]"
    end
  end
end
