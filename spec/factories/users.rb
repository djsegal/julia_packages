# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string
#

FactoryGirl.define do
  factory :user do
    name "MyString"
  end
end
