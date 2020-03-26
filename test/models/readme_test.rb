# == Schema Information
#
# Table name: readmes
#
#  id         :bigint           not null, primary key
#  html       :string
#  search     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  package_id :bigint           not null
#
# Indexes
#
#  index_readmes_on_package_id  (package_id)
#
# Foreign Keys
#
#  fk_rails_...  (package_id => packages.id)
#
require 'test_helper'

class ReadmeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
