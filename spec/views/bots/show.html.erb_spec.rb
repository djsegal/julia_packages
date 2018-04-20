require 'rails_helper'

RSpec.describe "bots/show", type: :view do
  before(:each) do
    @bot = assign(:bot, Bot.create!(
      :name => "Name",
      :avatar => "Avatar"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Avatar/)
  end
end
