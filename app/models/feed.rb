# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feed < ApplicationRecord

  has_many :subscriptions, dependent: :destroy
  has_many :news_items, through: :subscriptions

  include Batchable

  extend FriendlyId
  friendly_id :name

end
