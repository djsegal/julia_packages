require 'rails_helper'

RSpec.describe "repositories/show", type: :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :package => nil,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Url/)
  end
end
