# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  name           :string
#  packages_count :integer
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_packages_count  (packages_count)
#  index_users_on_slug            (slug) UNIQUE
#
class User < ApplicationRecord

  has_many :packages, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

end
