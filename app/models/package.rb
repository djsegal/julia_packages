# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  created     :datetime
#  description :string
#  github_url  :string
#  name        :string
#  registered  :boolean
#  search      :text
#  slug        :string
#  stars       :integer
#  updated     :datetime
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_packages_on_slug     (slug) UNIQUE
#  index_packages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Package < ApplicationRecord

  belongs_to :user, counter_cache: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  include PgSearch::Model

  pg_search_scope :deep_search,
    order_within_rank: "packages.updated DESC",
    against: :search

  pg_search_scope :shallow_search,
    order_within_rank: "packages.updated DESC",
    against: { name: 'A', description: 'B' },
    using: { tsearch: { prefix: true } }

  has_one :readme, dependent: :destroy

  has_many :labels, dependent: :destroy
  has_many :categories, through: :labels

  has_many :depender_dependencies, class_name: "Dependency", foreign_key: "depender_id", dependent: :destroy
  has_many :dependee_dependencies, class_name: "Dependency", foreign_key: "dependee_id", dependent: :destroy

  has_many :depending, through: :depender_dependencies, source: :dependee
  has_many :dependents, through: :dependee_dependencies, source: :depender

end
