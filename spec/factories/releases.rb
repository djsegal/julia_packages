# == Schema Information
#
# Table name: releases
#
#  id           :integer          not null, primary key
#  tag_name     :string
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_releases_on_published_at  (published_at)
#

FactoryGirl.define do
  factory :release do
    tag_name "MyString"
    published_at "2017-02-23 00:16:55"
  end
end
