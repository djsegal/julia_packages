# == Schema Information
#
# Table name: bots
#
#  id         :integer          not null, primary key
#  name       :string
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :bot do
    name "MyString"
    avatar "MyString"
  end
end
