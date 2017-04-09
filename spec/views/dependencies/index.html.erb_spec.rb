require 'rails_helper'

RSpec.describe "dependencies/index", type: :view do
  before(:each) do
    assign(:dependencies, [
      Dependency.create!(
        :dependent_id => nil,
        :depended_id => nil
      ),
      Dependency.create!(
        :dependent_id => nil,
        :depended_id => nil
      )
    ])
  end

  it "renders a list of dependencies" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
