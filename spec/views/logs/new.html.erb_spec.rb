require 'rails_helper'

RSpec.describe "logs/new", type: :view do
  before(:each) do
    assign(:log, Log.new())
  end

  it "renders new log form" do
    render

    assert_select "form[action=?][method=?]", logs_path, "post" do
    end
  end
end
