require 'rails_helper'

RSpec.describe "subscriptions/new", type: :view do
  before(:each) do
    assign(:subscription, Subscription.new(
      :feed => nil,
      :news_item => nil
    ))
  end

  it "renders new subscription form" do
    render

    assert_select "form[action=?][method=?]", subscriptions_path, "post" do

      assert_select "input#subscription_feed_id[name=?]", "subscription[feed_id]"

      assert_select "input#subscription_news_item_id[name=?]", "subscription[news_item_id]"
    end
  end
end
