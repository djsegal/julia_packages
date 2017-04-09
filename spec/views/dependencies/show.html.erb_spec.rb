require 'rails_helper'

RSpec.describe "dependencies/show", type: :view do
  before(:each) do
    @dependency = assign(:dependency, Dependency.create!(
      :dependent_id => nil,
      :depended_id => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
