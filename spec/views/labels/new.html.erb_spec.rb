require 'rails_helper'

RSpec.describe "labels/new", type: :view do
  before(:each) do
    assign(:label, Label.new(
      :category => nil,
      :package => nil
    ))
  end

  it "renders new label form" do
    render

    assert_select "form[action=?][method=?]", labels_path, "post" do

      assert_select "input#label_category_id[name=?]", "label[category_id]"

      assert_select "input#label_package_id[name=?]", "label[package_id]"
    end
  end
end
