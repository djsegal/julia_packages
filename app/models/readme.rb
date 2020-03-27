# == Schema Information
#
# Table name: readmes
#
#  id         :bigint           not null, primary key
#  html       :text
#  is_empty   :boolean
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
class Readme < ApplicationRecord
  belongs_to :package
end
