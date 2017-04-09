require 'rails_helper'

RSpec.describe "dependencies/edit", type: :view do
  before(:each) do
    @dependency = assign(:dependency, Dependency.create!(
      :dependent_id => nil,
      :depended_id => nil
    ))
  end

  it "renders the edit dependency form" do
    render

    assert_select "form[action=?][method=?]", dependency_path(@dependency), "post" do

      assert_select "input#dependency_dependent_id[name=?]", "dependency[dependent_id]"

      assert_select "input#dependency_depended_id[name=?]", "dependency[depended_id]"
    end
  end
end
