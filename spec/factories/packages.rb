# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  homepage    :string
#  owner_type  :string
#  owner_id    :integer
#  is_scoured  :boolean
#
# Indexes
#
#  index_packages_on_is_scoured               (is_scoured)
#  index_packages_on_name                     (name)
#  index_packages_on_owner_type_and_owner_id  (owner_type,owner_id)
#

FactoryGirl.define do
  factory :package do
    name "MyString"
  end
end
