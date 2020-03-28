# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  labels_count :integer
#  name         :string
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_categories_on_labels_count  (labels_count)
#  index_categories_on_slug          (slug) UNIQUE
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
