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

class Counter < ApplicationRecord

  COUNT_SUB_ROUTES ||= {
    forks: 'network',
    open_issues: 'issues',
    stargazers: 'stargazers',
    contributors: 'graphs/contributors'
  }

  belongs_to :package

end
