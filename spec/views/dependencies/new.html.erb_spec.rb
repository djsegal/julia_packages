require 'rails_helper'

RSpec.describe "dependencies/new", type: :view do
  before(:each) do
    assign(:dependency, Dependency.new(
      :dependent_id => nil,
      :depended_id => nil
    ))
  end

  it "renders new dependency form" do
    render

    assert_select "form[action=?][method=?]", dependencies_path, "post" do

      assert_select "input#dependency_dependent_id[name=?]", "dependency[dependent_id]"

      assert_select "input#dependency_depended_id[name=?]", "dependency[depended_id]"
    end
  end
end
