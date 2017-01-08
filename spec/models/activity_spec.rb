# == Schema Information
#
# Table name: activities
#
#  id                  :integer          not null, primary key
#  commits             :text
#  package_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  recent_commit_count :integer
#
# Indexes
#
#  index_activities_on_package_id           (package_id)
#  index_activities_on_recent_commit_count  (recent_commit_count)
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
