require 'rails_helper'

RSpec.describe "models/show", type: :view do
  before(:each) do
    @model = assign(:model, Model.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
