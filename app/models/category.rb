# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord

  include Batchable

  extend FriendlyId
  friendly_id :name

  has_many :labels, dependent: :destroy
  has_many :packages, through: :labels

end
