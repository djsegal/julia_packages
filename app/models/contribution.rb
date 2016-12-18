# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  score      :integer
#
# Indexes
#
#  index_contributions_on_package_id  (package_id)
#  index_contributions_on_uniqueness  (user_id,package_id) UNIQUE
#  index_contributions_on_user_id     (user_id)
#

class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :package
end
