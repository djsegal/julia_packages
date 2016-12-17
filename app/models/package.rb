# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#

class Package < ApplicationRecord
  has_one :repository
  delegate :url, to: :repository, allow_nil: true

  has_many :versions

  has_one :counter
  include Countable

  has_one :dater
end
