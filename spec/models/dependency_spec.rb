# == Schema Information
#
# Table name: dependencies
#
#  id           :integer          not null, primary key
#  dependent_id :integer
#  depended_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_shallow   :boolean
#
# Indexes
#
#  index_dependencies_on_depended_id   (depended_id)
#  index_dependencies_on_dependent_id  (dependent_id)
#  index_dependencies_on_uniqueness    (dependent_id,depended_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Dependency, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
