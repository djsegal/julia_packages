# == Schema Information
#
# Table name: packages
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#  homepage      :string
#  owner_type    :string
#  owner_id      :integer
#  is_registered :boolean
#  readme        :text
#  readme_type   :string
#
# Indexes
#
#  index_packages_on_is_registered            (is_registered)
#  index_packages_on_name                     (name)
#  index_packages_on_owner_type_and_owner_id  (owner_type,owner_id)
#

require 'rails_helper'

RSpec.describe Package, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
