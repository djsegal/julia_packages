require 'rails_helper'

RSpec.describe "references/index", type: :view do
  before(:each) do
    assign(:references, [
      Reference.create!(
        :link => "Link"
      ),
      Reference.create!(
        :link => "Link"
      )
    ])
  end

  it "renders a list of references" do
    render
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
