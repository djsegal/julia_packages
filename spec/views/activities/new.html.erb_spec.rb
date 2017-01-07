require 'rails_helper'

RSpec.describe "activities/new", type: :view do
  before(:each) do
    assign(:activity, Activity.new(
      :commits => "MyText",
      :package => nil
    ))
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activities_path, "post" do

      assert_select "textarea#activity_commits[name=?]", "activity[commits]"

      assert_select "input#activity_package_id[name=?]", "activity[package_id]"
    end
  end
end
