# == Schema Information
#
# Table name: labels
#
#  id          :integer          not null, primary key
#  category_id :integer
#  package_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_labels_on_category_id  (category_id)
#  index_labels_on_package_id   (package_id)
#  index_labels_on_uniqueness   (category_id,package_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Label, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
