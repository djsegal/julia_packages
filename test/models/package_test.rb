# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  readme      :string
#  stars       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
