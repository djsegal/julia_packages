require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
      :commits => "MyText",
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
