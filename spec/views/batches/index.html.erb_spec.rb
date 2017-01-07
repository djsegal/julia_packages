require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    assign(:batches, [
      Batch.create!(
        :marker => 2,
        :item => nil
      ),
      Batch.create!(
        :marker => 2,
        :item => nil
      )
    ])
  end

  it "renders a list of batches" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
