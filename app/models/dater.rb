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
#  touched    :datetime
#
# Indexes
#
#  index_daters_on_package_id  (package_id)
#

class Dater < ApplicationRecord

  DATE_TYPES = %w[
    created
    updated
    pushed
  ]

  belongs_to :package

  before_save :update_touch_time

  private

    def update_touch_time
      self.touched = \
        DATE_TYPES.map { |date_type| self[date_type] }.max
    end

end
