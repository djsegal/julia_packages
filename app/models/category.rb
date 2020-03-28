# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
class Category < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :labels, dependent: :destroy
  has_many :packages, through: :labels

end
