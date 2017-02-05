require 'rails_helper'

RSpec.describe "subscriptions/edit", type: :view do
  before(:each) do
    @subscription = assign(:subscription, Subscription.create!(
      :feed => nil,
      :news_item => nil
    ))
  end

  it "renders the edit subscription form" do
    render

    assert_select "form[action=?][method=?]", subscription_path(@subscription), "post" do

      assert_select "input#subscription_feed_id[name=?]", "subscription[feed_id]"

      assert_select "input#subscription_news_item_id[name=?]", "subscription[news_item_id]"
    end
  end
end
