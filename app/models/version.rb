# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  package_id :integer
#  major      :integer
#  minor      :integer
#  patch      :integer
#  sha1       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_versions_on_package_id  (package_id)
#

class Version < ApplicationRecord

  belongs_to :package

  before_save :parse_version_number

  private

    def parse_version_number
      self.major, self.minor, self.patch = number.split '.'
    end

    def self.default_scope
      order(major: :asc)
        .order(minor: :asc)
        .order(patch: :asc)
    end

end
