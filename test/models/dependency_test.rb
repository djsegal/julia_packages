# == Schema Information
#
# Table name: dependencies
#
#  id          :bigint           not null, primary key
#  shallow     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  dependee_id :bigint           not null
#  depender_id :bigint           not null
#
# Indexes
#
#  index_dependencies_on_dependee_id  (dependee_id)
#  index_dependencies_on_depender_id  (depender_id)
#
# Foreign Keys
#
#  fk_rails_...  (dependee_id => packages.id)
#  fk_rails_...  (depender_id => packages.id)
#
require 'test_helper'

class DependencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
