require 'rails_helper'

RSpec.describe "dummies/show", type: :view do
  before(:each) do
    @dummy = assign(:dummy, Dummy.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
