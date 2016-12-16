# == Schema Information
#
# Table name: counters
#
#  id         :integer          not null, primary key
#  fork       :integer
#  stargazer  :integer
#  watcher    :integer
#  subscriber :integer
#  open_issue :integer
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_counters_on_package_id  (package_id)
#

class Counter < ApplicationRecord
  belongs_to :package
end
