# == Schema Information
#
# Table name: dependencies
#
#  id           :integer          not null, primary key
#  dependent_id :integer
#  depended_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_shallow   :boolean
#
# Indexes
#
#  index_dependencies_on_depended_id   (depended_id)
#  index_dependencies_on_dependent_id  (dependent_id)
#  index_dependencies_on_uniqueness    (dependent_id,depended_id) UNIQUE
#

FactoryGirl.define do
  factory :dependency do
    dependent_id nil
    depended_id nil
  end
end
