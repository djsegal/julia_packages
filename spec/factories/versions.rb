# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  package_id :integer
#  major      :integer
#  minor      :integer
#  patch      :integer
#  sha1       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_versions_on_package_id  (package_id)
#

FactoryGirl.define do
  factory :version do
    package nil
    major 1
    minor 1
    patch 1
    sha1 "MyString"
    number "MyString"
  end
end
