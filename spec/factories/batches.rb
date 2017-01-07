# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  marker     :integer
#  item_type  :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_batches_on_item_type_and_item_id  (item_type,item_id)
#  index_batches_on_marker                 (marker)
#

FactoryGirl.define do
  factory :batch do
    marker 1
    item nil
  end
end
