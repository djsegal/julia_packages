# == Schema Information
#
# Table name: daters
#
#  id         :integer          not null, primary key
#  created    :datetime
#  updated    :datetime
#  pushed     :datetime
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  touched    :datetime
#
# Indexes
#
#  index_daters_on_package_id  (package_id)
#

FactoryGirl.define do
  factory :dater do
    created "2016-12-16 20:44:04"
    updated "2016-12-16 20:44:04"
    pushed "2016-12-16 20:44:04"
    package nil
  end
end
