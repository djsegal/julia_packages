# == Schema Information
#
# Table name: blurbs
#
#  id         :integer          not null, primary key
#  cargo      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :blurb do
    cargo "MyText"
  end
end
