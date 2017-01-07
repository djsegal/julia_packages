require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  before(:each) do
    @batch = assign(:batch, Batch.create!(
      :marker => 1,
      :item => nil
    ))
  end

  it "renders the edit batch form" do
    render

    assert_select "form[action=?][method=?]", batch_path(@batch), "post" do

      assert_select "input#batch_marker[name=?]", "batch[marker]"

      assert_select "input#batch_item_id[name=?]", "batch[item_id]"
    end
  end
end
