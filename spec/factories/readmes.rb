# == Schema Information
#
# Table name: readmes
#
#  id         :integer          not null, primary key
#  file_name  :string
#  cargo      :text
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_readmes_on_package_id  (package_id)
#

FactoryGirl.define do
  factory :readme do
    file_name "MyString"
    cargo "MyText"
    package nil
  end
end
