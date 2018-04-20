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

require 'rails_helper'

RSpec.describe Bot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
