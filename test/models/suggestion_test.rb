# == Schema Information
#
# Table name: suggestions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint           not null
#  package_id      :bigint           not null
#  sub_category_id :bigint
#
# Indexes
#
#  index_suggestions_on_category_id      (category_id)
#  index_suggestions_on_package_id       (package_id)
#  index_suggestions_on_sub_category_id  (sub_category_id)
#  unique_combination_index              (package_id,category_id,sub_category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (package_id => packages.id)
#  fk_rails_...  (sub_category_id => categories.id)
#
require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
