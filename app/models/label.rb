# == Schema Information
#
# Table name: labels
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  package_id  :bigint           not null
#
# Indexes
#
#  index_labels_on_category_id  (category_id)
#  index_labels_on_package_id   (package_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (package_id => packages.id)
#
class Label < ApplicationRecord
  belongs_to :package
  belongs_to :category, counter_cache: true
end
