require 'rails_helper'

RSpec.describe "counters/new", type: :view do
  before(:each) do
    assign(:counter, Counter.new(
      :fork => 1,
      :stargazer => 1,
      :open_issue => 1,
      :package => nil
    ))
  end

  it "renders new counter form" do
    render

    assert_select "form[action=?][method=?]", counters_path, "post" do

      assert_select "input#counter_fork[name=?]", "counter[fork]"

      assert_select "input#counter_stargazer[name=?]", "counter[stargazer]"

      assert_select "input#counter_open_issue[name=?]", "counter[open_issue]"

      assert_select "input#counter_package_id[name=?]", "counter[package_id]"
    end
  end
end
