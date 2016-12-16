# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Package < ApplicationRecord
end
