require 'rails_helper'

RSpec.describe "readmes/new", type: :view do
  before(:each) do
    assign(:readme, Readme.new(
      :file_name => "MyString",
      :cargo => "MyText",
      :package => nil
    ))
  end

  it "renders new readme form" do
    render

    assert_select "form[action=?][method=?]", readmes_path, "post" do

      assert_select "input#readme_file_name[name=?]", "readme[file_name]"

      assert_select "textarea#readme_cargo[name=?]", "readme[cargo]"

      assert_select "input#readme_package_id[name=?]", "readme[package_id]"
    end
  end
end
