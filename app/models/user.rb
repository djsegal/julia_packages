# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string
#

class User < ApplicationRecord

  include Ownable

  has_many :contributions, dependent: :destroy
  has_many :supported_packages, through: :contributions, source: :package

end
