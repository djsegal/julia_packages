# == Schema Information
#
# Table name: counters
#
#  id          :integer          not null, primary key
#  fork        :integer
#  stargazer   :integer
#  open_issue  :integer
#  package_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  contributor :integer
#
# Indexes
#
#  index_counters_on_package_id  (package_id)
#

require 'rails_helper'

RSpec.describe Counter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
