require 'rails_helper'

RSpec.describe "counters/show", type: :view do
  before(:each) do
    @counter = assign(:counter, Counter.create!(
      :fork => 2,
      :stargazer => 3,
      :watcher => 4,
      :subscriber => 5,
      :open_issue => 6,
      :package => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(//)
  end
end
