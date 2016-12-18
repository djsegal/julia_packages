# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contributions_on_package_id  (package_id)
#  index_contributions_on_uniqueness  (user_id,package_id) UNIQUE
#  index_contributions_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Contribution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
