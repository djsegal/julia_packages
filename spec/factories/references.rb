# == Schema Information
#
# Table name: references
#
#  id         :integer          not null, primary key
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :reference do
    link "MyString"
  end
end
