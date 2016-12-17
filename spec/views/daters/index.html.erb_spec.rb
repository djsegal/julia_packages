require 'rails_helper'

RSpec.describe "daters/index", type: :view do
  before(:each) do
    assign(:daters, [
      Dater.create!(
        :package => nil
      ),
      Dater.create!(
        :package => nil
      )
    ])
  end

  it "renders a list of daters" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
