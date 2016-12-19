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
#  owner_type  :string
#  owner_id    :integer
#
# Indexes
#
#  index_packages_on_name                     (name)
#  index_packages_on_owner_type_and_owner_id  (owner_type,owner_id)
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

  belongs_to :owner, polymorphic: true

  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, source: :user

  has_one :readme

end
