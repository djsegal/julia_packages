# == Schema Information
#
# Table name: packages
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#  homepage      :string
#  owner_type    :string
#  owner_id      :integer
#  is_registered :boolean
#  readme        :text
#  readme_type   :string
#
# Indexes
#
#  index_packages_on_is_registered            (is_registered)
#  index_packages_on_name                     (name)
#  index_packages_on_owner_type_and_owner_id  (owner_type,owner_id)
#

class Package < ApplicationRecord

  include PgSearch

  pg_search_scope :search_like, \
    against: [:name, :description, :readme], \
    using: {
      tsearch: { dictionary: 'english' },
      trigram: {
        only: [:name, :description]
      }
    }

  include Batchable

  extend FriendlyId
  friendly_id :name

  has_one :repository, dependent: :destroy
  delegate :url, to: :repository, allow_nil: true

  has_many :versions, dependent: :destroy

  has_one :counter, dependent: :destroy
  include Countable

  has_one :dater, dependent: :destroy

  belongs_to :owner, polymorphic: true

  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, source: :user

  has_many :labels, dependent: :destroy
  has_many :categories, through: :labels

  has_one :activity, dependent: :destroy

  def self.exclude_unregistered_packages(cookies={})
    if cookies[:include_unregistered_packages] == 'true'
      all
    else
      where(is_registered: true)
    end
  end

end
