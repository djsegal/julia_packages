require 'rails_helper'

RSpec.describe "counters/edit", type: :view do
  before(:each) do
    @counter = assign(:counter, Counter.create!(
      :fork => 1,
      :stargazer => 1,
      :open_issue => 1,
      :package => nil
    ))
  end

  it "renders the edit counter form" do
    render

    assert_select "form[action=?][method=?]", counter_path(@counter), "post" do

      assert_select "input#counter_fork[name=?]", "counter[fork]"

      assert_select "input#counter_stargazer[name=?]", "counter[stargazer]"

      assert_select "input#counter_open_issue[name=?]", "counter[open_issue]"

      assert_select "input#counter_package_id[name=?]", "counter[package_id]"
    end
  end
end
