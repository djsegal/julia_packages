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

class Repository < ApplicationRecord
  belongs_to :package
end
