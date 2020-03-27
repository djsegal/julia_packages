# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  created     :datetime
#  description :string
#  github_url  :string
#  name        :string
#  owner       :string
#  search      :text
#  stars       :integer
#  updated     :datetime
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
