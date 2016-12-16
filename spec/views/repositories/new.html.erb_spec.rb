require 'rails_helper'

RSpec.describe "repositories/new", type: :view do
  before(:each) do
    assign(:repository, Repository.new(
      :package => nil,
      :url => "MyString"
    ))
  end

  it "renders new repository form" do
    render

    assert_select "form[action=?][method=?]", repositories_path, "post" do

      assert_select "input#repository_package_id[name=?]", "repository[package_id]"

      assert_select "input#repository_url[name=?]", "repository[url]"
    end
  end
end
