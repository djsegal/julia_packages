require 'rails_helper'

RSpec.describe "readmes/show", type: :view do
  before(:each) do
    @readme = assign(:readme, Readme.create!(
      :file_name => "File Name",
      :cargo => "MyText",
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
