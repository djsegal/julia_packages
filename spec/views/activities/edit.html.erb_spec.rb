require 'rails_helper'

RSpec.describe "activities/edit", type: :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
      :commits => "MyText",
      :package => nil
    ))
  end

  it "renders the edit activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do

      assert_select "textarea#activity_commits[name=?]", "activity[commits]"

      assert_select "input#activity_package_id[name=?]", "activity[package_id]"
    end
  end
end
