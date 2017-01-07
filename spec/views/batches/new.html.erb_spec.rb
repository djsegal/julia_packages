require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    assign(:batch, Batch.new(
      :marker => 1,
      :item => nil
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", batches_path, "post" do

      assert_select "input#batch_marker[name=?]", "batch[marker]"

      assert_select "input#batch_item_id[name=?]", "batch[item_id]"
    end
  end
end
