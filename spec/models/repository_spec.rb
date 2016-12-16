# == Schema Information
#
# Table name: repositories
#
#  id         :integer          not null, primary key
#  package_id :integer
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_repositories_on_package_id  (package_id)
#

require 'rails_helper'

RSpec.describe Repository, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
