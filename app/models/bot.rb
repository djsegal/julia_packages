# == Schema Information
#
# Table name: bots
#
#  id         :integer          not null, primary key
#  name       :string
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bot < ApplicationRecord

  include Batchable

  include Ownable

end
