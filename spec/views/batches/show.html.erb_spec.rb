require 'rails_helper'

RSpec.describe "batches/show", type: :view do
  before(:each) do
    @batch = assign(:batch, Batch.create!(
      :marker => 2,
      :item => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
