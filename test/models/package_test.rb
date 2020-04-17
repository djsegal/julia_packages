# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  created     :datetime
#  description :string
#  github_url  :string
#  name        :string
#  registered  :boolean
#  search      :text
#  slug        :string
#  stars       :integer
#  updated     :datetime
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_packages_on_slug     (slug) UNIQUE
#  index_packages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
