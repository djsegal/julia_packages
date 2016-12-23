# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  repos      :integer
#  followers  :integer
#  following  :integer
#  owner_type :string
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gists      :integer
#
# Indexes
#
#  index_infos_on_owner_type_and_owner_id  (owner_type,owner_id)
#

require 'rails_helper'

RSpec.describe Info, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
