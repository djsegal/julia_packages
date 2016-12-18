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
#
# Indexes
#
#  index_packages_on_name  (name)
#

FactoryGirl.define do
  factory :package do
    name "MyString"
  end
end
