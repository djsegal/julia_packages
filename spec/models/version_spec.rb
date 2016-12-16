# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  package_id :integer
#  major      :integer
#  minor      :integer
#  patch      :integer
#  sha1       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_versions_on_package_id  (package_id)
#

require 'rails_helper'

RSpec.describe Version, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
