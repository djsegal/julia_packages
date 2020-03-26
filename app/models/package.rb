# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  stars       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Package < ApplicationRecord
  has_one :readme
end
