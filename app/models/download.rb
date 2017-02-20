# == Schema Information
#
# Table name: downloads
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Download < ApplicationRecord

  extend FriendlyId
  friendly_id :name

end
