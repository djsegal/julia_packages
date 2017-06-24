# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  visit_token      :string
#  visitor_token    :string
#  ip               :string
#  user_agent       :text
#  referrer         :text
#  landing_page     :text
#  user_id          :integer
#  referring_domain :string
#  search_keyword   :string
#  browser          :string
#  os               :string
#  device_type      :string
#  screen_height    :integer
#  screen_width     :integer
#  country          :string
#  region           :string
#  city             :string
#  postal_code      :string
#  latitude         :decimal(, )
#  longitude        :decimal(, )
#  utm_source       :string
#  utm_medium       :string
#  utm_term         :string
#  utm_content      :string
#  utm_campaign     :string
#  started_at       :datetime
#
# Indexes
#
#  index_visits_on_user_id      (user_id)
#  index_visits_on_visit_token  (visit_token) UNIQUE
#

class Visit < ApplicationRecord
  has_many :ahoy_events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true
end
