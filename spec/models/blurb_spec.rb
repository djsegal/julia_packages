# == Schema Information
#
# Table name: blurbs
#
#  id         :integer          not null, primary key
#  cargo      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Blurb, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
