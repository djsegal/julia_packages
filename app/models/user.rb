# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

  has_many :ownerships, dependent: :destroy
  has_many :contributions, dependent: :destroy

  has_many :own_packages, through: :ownerships, source: :package
  has_many :supported_packages, through: :contributions, source: :package

end
