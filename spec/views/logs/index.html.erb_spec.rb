require 'rails_helper'

RSpec.describe "logs/index", type: :view do
  before(:each) do
    assign(:logs, [
      Log.create!(),
      Log.create!()
    ])
  end

  it "renders a list of logs" do
    render
  end
end
