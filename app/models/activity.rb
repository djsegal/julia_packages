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

class Activity < ApplicationRecord
  belongs_to :package
  serialize :commits

  before_save :update_commit_count

  private

    def update_commit_count
      self.recent_commit_count = \
        self.commits.last(10).sum
    end

end
