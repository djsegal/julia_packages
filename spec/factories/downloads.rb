# == Schema Information
#
# Table name: downloads
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :download do
    name "MyString"
    file "MyString"
  end
end
