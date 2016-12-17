# == Schema Information
#
# Table name: daters
#
#  id         :integer          not null, primary key
#  created    :datetime
#  updated    :datetime
#  pushed     :datetime
#  package_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_daters_on_package_id  (package_id)
#

require 'rails_helper'

RSpec.describe Dater, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
