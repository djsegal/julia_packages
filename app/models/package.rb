# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  homepage    :string
#
# Indexes
#
#  index_packages_on_name  (name)
#

class Package < ApplicationRecord

  extend FriendlyId
  friendly_id :name

  has_one :repository
  delegate :url, to: :repository, allow_nil: true

  has_many :versions

  has_one :counter
  include Countable

  has_one :dater

  has_one :ownership, dependent: :destroy
  has_many :contributions, dependent: :destroy

  has_one :owner, through: :ownership, source: :user
  has_many :contributors, through: :contributions, source: :user

end
