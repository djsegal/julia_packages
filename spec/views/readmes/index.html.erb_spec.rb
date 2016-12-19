require 'rails_helper'

RSpec.describe "readmes/index", type: :view do
  before(:each) do
    assign(:readmes, [
      Readme.create!(
        :file_name => "File Name",
        :cargo => "MyText",
        :package => nil
      ),
      Readme.create!(
        :file_name => "File Name",
        :cargo => "MyText",
        :package => nil
      )
    ])
  end

  it "renders a list of readmes" do
    render
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
