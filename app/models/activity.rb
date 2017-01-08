# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  commits    :text
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_activities_on_package_id  (package_id)
#

class Activity < ApplicationRecord
  belongs_to :package
  serialize :commits
end