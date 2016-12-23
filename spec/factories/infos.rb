# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  repos      :integer
#  followers  :integer
#  following  :integer
#  owner_type :string
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gists      :integer
#
# Indexes
#
#  index_infos_on_owner_type_and_owner_id  (owner_type,owner_id)
#

FactoryGirl.define do
  factory :info do
    repos 1
    followers 1
    following 1
    created "2016-12-22 23:41:58"
    owner nil
  end
end
