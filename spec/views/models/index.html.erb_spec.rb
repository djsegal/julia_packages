require 'rails_helper'

RSpec.describe "models/index", type: :view do
  before(:each) do
    assign(:models, [
      Model.create!(),
      Model.create!()
    ])
  end

  it "renders a list of models" do
    render
  end
end
