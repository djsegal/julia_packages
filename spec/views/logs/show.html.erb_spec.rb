require 'rails_helper'

RSpec.describe "logs/show", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
