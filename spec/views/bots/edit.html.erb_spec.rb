require 'rails_helper'

RSpec.describe "bots/edit", type: :view do
  before(:each) do
    @bot = assign(:bot, Bot.create!(
      :name => "MyString",
      :avatar => "MyString"
    ))
  end

  it "renders the edit bot form" do
    render

    assert_select "form[action=?][method=?]", bot_path(@bot), "post" do

      assert_select "input#bot_name[name=?]", "bot[name]"

      assert_select "input#bot_avatar[name=?]", "bot[avatar]"
    end
  end
end
