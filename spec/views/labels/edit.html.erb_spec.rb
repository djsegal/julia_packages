require 'rails_helper'

RSpec.describe "labels/edit", type: :view do
  before(:each) do
    @label = assign(:label, Label.create!(
      :category => nil,
      :package => nil
    ))
  end

  it "renders the edit label form" do
    render

    assert_select "form[action=?][method=?]", label_path(@label), "post" do

      assert_select "input#label_category_id[name=?]", "label[category_id]"

      assert_select "input#label_package_id[name=?]", "label[package_id]"
    end
  end
end
