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

class Info < ApplicationRecord

  COUNT_SUB_ROUTES = {
    repos: '?tab=repositories',
    followers: 'followers',
    following: 'following',
    gists: 'https://gist.github.com',
  }

  belongs_to :owner, polymorphic: true

end
