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

FactoryGirl.define do
  factory :counter do
    fork 1
    stargazer 1
    open_issue 1
    package nil
  end
end
