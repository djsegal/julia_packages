require 'rails_helper'

RSpec.describe "repositories/edit", type: :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :package => nil,
      :url => "MyString"
    ))
  end

  it "renders the edit repository form" do
    render

    assert_select "form[action=?][method=?]", repository_path(@repository), "post" do

      assert_select "input#repository_package_id[name=?]", "repository[package_id]"

      assert_select "input#repository_url[name=?]", "repository[url]"
    end
  end
end
