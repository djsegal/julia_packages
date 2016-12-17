require 'rails_helper'

RSpec.describe "dummies/index", type: :view do
  before(:each) do
    assign(:dummies, [
      Dummy.create!(),
      Dummy.create!()
    ])
  end

  it "renders a list of dummies" do
    render
  end
end
