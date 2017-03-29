require 'rails_helper'

RSpec.describe "models/new", type: :view do
  before(:each) do
    assign(:model, Model.new())
  end

  it "renders new model form" do
    render

    assert_select "form[action=?][method=?]", models_path, "post" do
    end
  end
end
