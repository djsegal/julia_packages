# == Schema Information
#
# Table name: ownerships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ownerships_on_package_id          (package_id)
#  index_ownerships_on_package_uniqueness  (package_id) UNIQUE
#  index_ownerships_on_uniqueness          (user_id,package_id) UNIQUE
#  index_ownerships_on_user_id             (user_id)
#

FactoryGirl.define do
  factory :ownership do
    user nil
    package nil
  end
end
