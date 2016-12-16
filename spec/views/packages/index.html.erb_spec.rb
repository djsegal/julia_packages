require 'rails_helper'

RSpec.describe "packages/index", type: :view do
  before(:each) do
    assign(:packages, [
      Package.create!(
        :name => "Name"
      ),
      Package.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of packages" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
