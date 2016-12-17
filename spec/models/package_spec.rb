# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#
# Indexes
#
#  index_packages_on_name  (name)
#

require 'rails_helper'

RSpec.describe Package, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
