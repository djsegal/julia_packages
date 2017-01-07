# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord

  include Batchable

  include Ownable

end
