# == Schema Information
#
# Table name: suggestions
#
#  id                :bigint           not null, primary key
#  category_slug     :string
#  package_slug      :string
#  sub_category_slug :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
