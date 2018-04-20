require 'rails_helper'

RSpec.describe "bots/new", type: :view do
  before(:each) do
    assign(:bot, Bot.new(
      :name => "MyString",
      :avatar => "MyString"
    ))
  end

  it "renders new bot form" do
    render

    assert_select "form[action=?][method=?]", bots_path, "post" do

      assert_select "input#bot_name[name=?]", "bot[name]"

      assert_select "input#bot_avatar[name=?]", "bot[avatar]"
    end
  end
end
