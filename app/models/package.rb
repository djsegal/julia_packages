# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  created     :datetime
#  description :string
#  github_url  :string
#  name        :string
#  owner       :string
#  search      :text
#  slug        :string
#  stars       :integer
#  updated     :datetime
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_packages_on_slug  (slug) UNIQUE
#
class Package < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  include PgSearch::Model
  pg_search_scope :search, against: :search, order_within_rank: "packages.updated DESC"

  has_one :readme, dependent: :destroy

  has_many :labels, dependent: :destroy
  has_many :categories, through: :labels

end
