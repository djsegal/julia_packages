# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  name           :string
#  packages_count :integer
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_packages_count  (packages_count)
#  index_users_on_slug            (slug) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
