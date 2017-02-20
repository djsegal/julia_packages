require 'rails_helper'

RSpec.describe "downloads/show", type: :view do
  before(:each) do
    @download = assign(:download, Download.create!(
      :name => "Name",
      :file => "File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/File/)
  end
end
