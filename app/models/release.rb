# == Schema Information
#
# Table name: releases
#
#  id           :integer          not null, primary key
#  tag_name     :string
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_releases_on_published_at  (published_at)
#

class Release < ApplicationRecord
end
